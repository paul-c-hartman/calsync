# typed: false

require 'rails_helper'

RSpec.describe Flow do
  define_method(:build_calendar_for) do |user, provider_id|
    account = UserAccount.create!(user: user, email: "#{provider_id}@example.com", provider: 'google')
    Calendar.create!(user_account: account, provider_id: provider_id)
  end

  it 'belongs to source and destination calendars and user' do # rubocop:disable RSpec/MultipleExpectations
    source_assoc = described_class.reflect_on_association(:source)
    destination_assoc = described_class.reflect_on_association(:destination)
    user_assoc = described_class.reflect_on_association(:user)

    expect(source_assoc.macro).to eq(:belongs_to)
    expect(source_assoc.options[:class_name]).to eq('Calendar')
    expect(source_assoc.options[:foreign_key]).to eq('source_calendar_id')

    expect(destination_assoc.macro).to eq(:belongs_to)
    expect(destination_assoc.options[:class_name]).to eq('Calendar')
    expect(destination_assoc.options[:foreign_key]).to eq('destination_calendar_id')

    expect(user_assoc.macro).to eq(:belongs_to)
  end

  it 'has many flow_filters and flow_transforms' do
    filters_assoc = described_class.reflect_on_association(:flow_filters)
    transforms_assoc = described_class.reflect_on_association(:flow_transforms)

    expect(filters_assoc.macro).to eq(:has_many)
    expect(filters_assoc.options[:dependent]).to eq(:destroy)

    expect(transforms_assoc.macro).to eq(:has_many)
    expect(transforms_assoc.options[:dependent]).to eq(:destroy)
  end

  it 'rejects same source and destination calendar' do
    user = User.create!(display_name: 'User One')
    calendar = build_calendar_for(user, 'calendar-1')
    flow = described_class.new(user: user, source: calendar, destination: calendar)

    expect(flow).not_to be_valid
    expect(flow.errors[:source]).to include('must be different from destination calendar')
  end

  it 'rejects flow when source or destination does not belong to flow user' do
    user_one = User.create!(display_name: 'User One')
    user_two = User.create!(display_name: 'User Two')

    source = build_calendar_for(user_one, 'source-1')
    destination = build_calendar_for(user_two, 'destination-1')
    flow = described_class.new(user: user_one, source: source, destination: destination)

    expect(flow).not_to be_valid
    expect(flow.errors[:base]).to include('Source and destination calendars must belong to the same user as the flow')
  end
end
