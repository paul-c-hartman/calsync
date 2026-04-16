# typed: false

require 'rails_helper'

RSpec.describe Event do
  it 'belongs to calendar' do
    association = described_class.reflect_on_association(:calendar)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'validates presence of provider_id, starts_at, and ends_at' do
    event = described_class.new(
      calendar: create_calendar!,
      provider_id: nil,
      starts_at: nil,
      ends_at: nil
    )

    expect(event).not_to be_valid
    expect(event.errors[:provider_id]).to be_present
    expect(event.errors[:starts_at]).to be_present
    expect(event.errors[:ends_at]).to be_present
  end

  it 'requires ends_at to be after starts_at' do
    now = Time.current
    event = described_class.new(
      calendar: create_calendar!,
      provider_id: 'evt-1',
      starts_at: now,
      ends_at: now
    )

    expect(event).not_to be_valid
    expect(event.errors[:ends_at]).to include('must be after the start time')
  end

  it 'uses expected defaults for all_day and busy' do
    event = described_class.new

    expect(event.all_day).to be(false)
    expect(event.busy).to be(true)
  end
end
