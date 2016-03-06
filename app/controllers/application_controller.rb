class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?

  # after_action :verify_authorized

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:full_name]
      devise_parameter_sanitizer.for(:account_update) << [:full_name]
    end

  private

    def user_not_authorized(exception)
      if user_signed_in?
        human_name = exception.policy.record.model_name.human
        redirect_to root_url,
                    alert: "You are not allowed to access this #{human_name}"
      else
        render 'devise/sessions/new', alert: 'Please sign in.'
      end
    end
end
