# typed: true

class ApplicationController < ActionController::Base
  before_action :check_session_timeout
  before_action :update_session_timestamp

  helper_method :current_user, :user_signed_in?, :require_authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def update_session_timestamp
    session[:last_seen] = Time.current
  end

  # 30-minute sliding expiration
  def check_session_timeout
    timeout_minutes = 30.minutes

    if session[:last_seen].present? && (Time.current - Time.parse(session[:last_seen].to_s)) > timeout_minutes
      reset_session
      flash[:alert] = "Your session has expired due to inactivity."
    end
  end

  def user_signed_in?
    !!current_user
  end

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_authentication(resource: nil)
    if user_signed_in?
      if resource.nil? || current_user.can_access?(resource)
        nil
      else
        redirect_back fallback_location: root_path, alert: "You don't have permission to access this #{resource.class.humanize.downcase}."
      end
    else
      redirect_back fallback_location: root_path, alert: "You must be logged in to access this page"
    end
  end
end
