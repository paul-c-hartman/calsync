# typed: false

class UserAccount < ApplicationRecord
  belongs_to :user
  has_many :calendars, dependent: :destroy

  validates_presence_of :email, :provider, :user
end
