class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :auth_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end

  private

    # http://railscasts.com/episodes/241-simple-omniauth-revised, 2019-08-07
    def auth_user!
      user = User.find_for_shibboleth_oauth(request, current_user)
      session[:user_id] = user.id
      session[:cookie_version] = Rails.application.config.quartermaster_cookie_version
    end
    helper_method :auth

    def current_ability
      @current_ability ||= Ability.new(current_user, request.remote_ip)
    end

    def current_user
      if session[:cookie_version] == Rails.application.config.quartermaster_cookie_version && session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
      return @current_user
    end
    helper_method :current_user

end
