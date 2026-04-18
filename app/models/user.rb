# typed: false

class User < ApplicationRecord
  has_many :user_accounts, dependent: :destroy
  has_many :calendars, through: :user_accounts
  has_many :flows
  has_many :flow_filters, through: :flows
  has_many :flow_transforms, through: :flows

  def can_access?(resource)
    case resource
    when User
      id == resource.id
    when UserAccount
      user_accounts.exists?(id: resource.id)
    when Calendar
      calendars.exists?(id: resource.id)
    when Flow
      flows.exists?(id: resource.id)
    when FlowFilter
      flow_filters.exists?(id: resource.id)
    when FlowTransform
      flow_transforms.exists?(id: resource.id)
    else
      false
    end
  end
end
