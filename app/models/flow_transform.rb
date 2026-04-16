# typed: false

class FlowTransform < ApplicationRecord
  belongs_to :flow

  enum :action, { clear: 0, set: 1, append: 2, prepend: 3 }, validate: true

  before_validation :set_position, on: :create

  validates_presence_of :flow, :field_name, :action, :position
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :value_required_for_set_append_or_prepend
  validate :value_must_be_blank_for_clear

  private

  def set_position
    return if position.present? || flow.nil?

    flow.with_lock do
      next_position = flow.flow_transforms.maximum(:position).to_i + 1
      self.position = next_position
    end
  end

  def value_required_for_set_append_or_prepend
    return unless set? || append? || prepend?
    errors.add(:value_json, "must be present for set/append/prepend") if value_json.blank?
  end

  def value_must_be_blank_for_clear
    return unless clear?
    errors.add(:value_json, "must be blank for clear") if value_json.present?
  end
end
