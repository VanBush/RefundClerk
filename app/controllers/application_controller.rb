class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized(exception)
      if user_signed_in?
        redirect_to root_url, alert: exception.message, status: :forbidden
      else
        redirect_to new_user_session_url, alert: 'Please sign in.'
      end
    end
end
