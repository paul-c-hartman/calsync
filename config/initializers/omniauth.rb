Rails.application.config.omniauth_strategies = {
  google_oauth2: "Google",
  microsoft_graph: "Microsoft"
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: 'openid,email,profile,.../auth/calendar.calendars.readonly,.../auth/calendar.events.readonly.../auth/calendar.events.owned',
    prompt: 'select_account',
    image_aspect_ratio: 'square',
    image_size: 50
  }

  provider :microsoft_graph, ENV['MICROSOFT_CLIENT_ID'], ENV['MICROSOFT_CLIENT_SECRET'], {
    scope: 'offline_access openid User.Read Calendars.ReadWrite.Shared',
    skip_domain_verification: true
  }

  if Rails.env.development?
    provider :developer,
      fields: [:name, :email],
      uid_field: :email
    
    configure do |config|
      config.allowed_request_methods = [:get, :post]
    end

    Rails.application.config.omniauth_strategies[:developer] = "Developer"
  end
end
