# typed: false

class Flow < ApplicationRecord
  belongs_to :source, class_name: "Calendar", foreign_key: "source_calendar_id", inverse_of: :outgoing_flows
  belongs_to :destination, class_name: "Calendar", foreign_key: "destination_calendar_id", inverse_of: :incoming_flows
  belongs_to :user
  has_many :flow_filters, dependent: :destroy
  has_many :flow_transforms, dependent: :destroy

  validates_presence_of :source, :destination, :user
  # Validate that source and destination calendars are not the same
  validates :source, comparison: { other_than: :destination, message: "must be different from destination calendar" }
  validates :destination, comparison: { other_than: :source, message: "must be different from source calendar" }
  validate :calendars_must_belong_to_user_of_flow

  private

  def calendars_must_belong_to_user_of_flow
    if source.user_account.user_id != user_id || destination.user_account.user_id != user_id
      errors.add(:base, "Source and destination calendars must belong to the same user as the flow")
    end
  end
end
