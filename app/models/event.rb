# typed: false

class Event < ApplicationRecord
  belongs_to :calendar

  validates_presence_of :calendar, :provider_id, :starts_at, :ends_at
  validates :ends_at, comparison: { greater_than: :starts_at, message: "must be after the start time" }
end
