# typed: false

class FlowFilter < ApplicationRecord
  enum :operator, { equals: 0, does_not_equal: 1, greater_than: 2, less_than: 3, contains: 4, blank: 5, present: 6 }, validate: true

  belongs_to :flow

  validates_presence_of :flow, :field_name
  validate :value_required_for_non_blank_operators

  private

  def value_required_for_non_blank_operators
    return if blank? || present?
    errors.add(:value_json, "must be present for operators other than blank/present") if value_json.blank?
  end
end
