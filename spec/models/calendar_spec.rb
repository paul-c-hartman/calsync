# typed: false

require 'rails_helper'

RSpec.describe Calendar, type: :model do
  it 'belongs to user_account' do
    association = described_class.reflect_on_association(:user_account)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'has many outgoing_flows' do
    association = described_class.reflect_on_association(:outgoing_flows)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:class_name]).to eq('Flow')
    expect(association.options[:foreign_key]).to eq('source_calendar_id')
  end

  it 'has many incoming_flows' do
    association = described_class.reflect_on_association(:incoming_flows)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:class_name]).to eq('Flow')
    expect(association.options[:foreign_key]).to eq('destination_calendar_id')
  end

  it 'has many events' do
    association = described_class.reflect_on_association(:events)
    expect(association.macro).to eq(:has_many)
  end

  it 'validates provider_id presence' do
    user = User.create!(display_name: 'Test User')
    user_account = UserAccount.create!(user: user, email: 'user@example.com', provider: 'google')
    calendar = described_class.new(user_account: user_account, provider_id: nil)

    expect(calendar).not_to be_valid
    expect(calendar.errors[:provider_id]).to be_present
  end

  it 'has uniqueness validator on provider_id scoped to user_account_id' do
    validator = described_class.validators_on(:provider_id).find do |v|
      v.is_a?(ActiveRecord::Validations::UniquenessValidator)
    end

    expect(validator).not_to be_nil
    expect(Array(validator.options[:scope])).to eq([ :user_account_id ])
  end
end
