# typed: false

require 'rails_helper'

RSpec.describe UserAccount do
  it 'belongs to user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'has many calendars' do
    association = described_class.reflect_on_association(:calendars)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:dependent]).to eq(:destroy)
  end

  it 'validates email presence' do
    user = User.new(display_name: 'Test User')
    account = described_class.new(user: user, provider: 'google', email: nil)

    expect(account).not_to be_valid
    expect(account.errors[:email]).to be_present
  end

  it 'validates provider presence' do
    user = User.new(display_name: 'Test User')
    account = described_class.new(user: user, provider: nil, email: 'user@example.com')

    expect(account).not_to be_valid
    expect(account.errors[:provider]).to be_present
  end
end
