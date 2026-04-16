# typed: false

module ModelHelpers
  def create_user!(count: 1)
    users = count.times.map do |num|
      User.create!(display_name: "Test User #{num}")
    end
    count == 1 ? users.first : users
  end

  def create_user_account!(count: 1, preserve_user: false)
    if preserve_user
      user = create_user!
      users = [ user ] * count
    else
      users = create_user!(count: count)
      users = [ users ] unless users.is_a?(Array)
    end

    accounts = users.map.with_index do |user, num|
      UserAccount.create!(user: user, email: "test#{num}@example.com", provider: "google")
    end
    count == 1 ? accounts.first : accounts
  end

  def create_calendar!(count: 1, preserve_user: false)
    user_accounts = create_user_account!(count: count, preserve_user: preserve_user)
    user_accounts = [ user_accounts ] unless user_accounts.is_a?(Array)

    calendars = user_accounts.map.with_index do |user_account, num|
      Calendar.create!(user_account: user_account, provider_id: "calendar-#{num}")
    end
    count == 1 ? calendars.first : calendars
  end

  def create_flow!(count: 1)
    calendars = create_calendar!(count: count * 2, preserve_user: true)
    flows = calendars.each_slice(2).map.with_index do |slice, num|
      source, destination = *slice
      user = source.user_account.user
      Flow.create!(user: user, source: source, destination: destination)
    end
    count == 1 ? flows.first : flows
  end

  def create_flow_filter!(count: 1)
    flows = create_flow!(count: count)
    flows = [ flows ] unless flows.is_a?(Array)
    filters = flows.map.with_index do |flow, num|
      FlowFilter.create!(flow: flow, field_name: "type-#{num}", operator: 5)
    end
    count == 1 ? filters.first : filters
  end

  def create_flow_transform!(count: 1)
    flows = create_flow!(count: count)
    flows = [ flows ] unless flows.is_a?(Array)
    transforms = flows.map.with_index do |flow, num|
      FlowTransform.create!(flow: flow, field_name: "field-#{num}", action: 0, position: num)
    end
    count == 1 ? transforms.first : transforms
  end
end
