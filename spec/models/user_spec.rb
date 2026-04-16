# typed: false

require 'rails_helper'

RSpec.describe User do
  it 'has many user_accounts' do
    association = described_class.reflect_on_association(:user_accounts)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:dependent]).to eq(:destroy)
  end

  it 'has many calendars through user_accounts' do
    association = described_class.reflect_on_association(:calendars)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:through]).to eq(:user_accounts)
  end

  it 'has many flows' do
    association = described_class.reflect_on_association(:flows)
    expect(association.macro).to eq(:has_many)
  end
end
