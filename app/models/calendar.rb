# typed: false

class Calendar < ApplicationRecord
  belongs_to :user_account
  has_many :outgoing_flows, class_name: "Flow", foreign_key: "source_calendar_id", inverse_of: :source, dependent: :destroy
  has_many :incoming_flows, class_name: "Flow", foreign_key: "destination_calendar_id", inverse_of: :destination, dependent: :destroy
  has_many :events, dependent: :destroy

  validates_presence_of :user_account, :provider_id
  validates_uniqueness_of :provider_id, scope: :user_account_id
end
