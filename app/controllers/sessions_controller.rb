# typed: false

class SessionsController < ApplicationController
  def new
    render :new, locals: { auth_strategies: Rails.application.config.omniauth_strategies } # Login page
  end

  def create
    user_info = request.env["omniauth.auth"]

    # First, check if there's an existing user with a matching UserAccount
    user_account = UserAccount.find_by(provider: user_info.provider, email: user_info.info.email)

    if user_account
      # If we found a matching UserAccount, use its associated User
      user = user_account.user
    else
      # If no matching UserAccount, create a new User and UserAccount
      user = User.create!(display_name: user_info.info.name || "Unnamed User")
      user.user_accounts.create!(
        provider: user_info.provider,
        email: user_info.info.email
      )
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: "Successfully logged in with #{user_info.provider.titleize}!"
  end

  def failure
    redirect_to login_path, alert: "Authentication failed, please try again."
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "Logged out!"
  end
end
