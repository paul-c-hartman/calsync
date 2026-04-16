# typed: false

require 'rails_helper'

RSpec.describe FlowFilter, type: :model do
  def create_flow!
    user = User.create!(display_name: 'Filter User')
    account = UserAccount.create!(user: user, email: 'filter@example.com', provider: 'google')
    source = Calendar.create!(user_account: account, provider_id: 'source-filter')
    destination = Calendar.create!(user_account: account, provider_id: 'destination-filter')
    Flow.create!(user: user, source: source, destination: destination)
  end

  it 'belongs to flow' do
    association = described_class.reflect_on_association(:flow)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'defines expected operator enum values' do
    expect(described_class.operators).to eq(
      'equals' => 0,
      'does_not_equal' => 1,
      'greater_than' => 2,
      'less_than' => 3,
      'contains' => 4,
      'blank' => 5,
      'present' => 6
    )
  end

  it 'validates presence of field_name' do
    filter = described_class.new(flow: create_flow!, field_name: nil, operator: :equals, value_json: { value: true })

    expect(filter).not_to be_valid
    expect(filter.errors[:field_name]).to be_present
  end

  it 'requires value_json for non-blank operators' do
    filter = described_class.new(flow: create_flow!, field_name: 'busy', operator: :equals, value_json: nil)

    expect(filter).not_to be_valid
    expect(filter.errors[:value_json]).to include('must be present for operators other than blank/present')
  end

  it 'allows blank value_json for blank and present operators' do
    blank_filter = described_class.new(flow: create_flow!, field_name: 'description', operator: :blank, value_json: nil)
    present_filter = described_class.new(flow: create_flow!, field_name: 'description', operator: :present, value_json: nil)

    expect(blank_filter).to be_valid
    expect(present_filter).to be_valid
  end
end
