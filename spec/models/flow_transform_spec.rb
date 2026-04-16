# typed: false

require 'rails_helper'

RSpec.describe FlowTransform, type: :model do
  def create_flow!
    user = User.create!(display_name: 'Transform User')
    account = UserAccount.create!(user: user, email: 'transform@example.com', provider: 'google')
    source = Calendar.create!(user_account: account, provider_id: 'source-transform')
    destination = Calendar.create!(user_account: account, provider_id: 'destination-transform')
    Flow.create!(user: user, source: source, destination: destination)
  end

  it 'belongs to flow' do
    association = described_class.reflect_on_association(:flow)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'defines expected action enum values' do
    expect(described_class.actions).to eq(
      'set' => 0,
      'clear' => 1,
      'append' => 2,
      'prepend' => 3
    )
  end

  it 'validates field_name presence' do
    transform = described_class.new(flow: create_flow!, field_name: nil, action: :clear)

    expect(transform).not_to be_valid
    expect(transform.errors[:field_name]).to be_present
  end

  it 'validates non-negative integer position' do
    transform = described_class.new(
      flow: create_flow!,
      field_name: 'title',
      action: :set,
      value_json: { value: 'Updated title' },
      position: -1
    )

    expect(transform).not_to be_valid
    expect(transform.errors[:position]).to be_present
  end

  it 'requires value_json for set, append, and prepend actions' do
    set_transform = described_class.new(flow: create_flow!, field_name: 'title', action: :set, value_json: nil)
    append_transform = described_class.new(flow: create_flow!, field_name: 'title', action: :append, value_json: nil)
    prepend_transform = described_class.new(flow: create_flow!, field_name: 'title', action: :prepend, value_json: nil)

    expect(set_transform).not_to be_valid
    expect(append_transform).not_to be_valid
    expect(prepend_transform).not_to be_valid
  end

  it 'requires value_json to be blank for clear action' do
    transform = described_class.new(flow: create_flow!, field_name: 'title', action: :clear, value_json: { value: 'x' })

    expect(transform).not_to be_valid
    expect(transform.errors[:value_json]).to include('must be blank for clear')
  end

  it 'auto-assigns position in sequence within a flow' do
    flow = create_flow!

    first = described_class.create!(flow: flow, field_name: 'title', action: :set, value_json: { value: 'A' })
    second = described_class.create!(flow: flow, field_name: 'title', action: :append, value_json: { value: 'B' })

    expect(first.position).to eq(1)
    expect(second.position).to eq(2)
  end
end
