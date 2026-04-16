# typed: false

class User < ApplicationRecord
  has_many :user_accounts, dependent: :destroy
  has_many :calendars, through: :user_accounts
  has_many :flows
end
