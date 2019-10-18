class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authn_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end

  private

    # http://railscasts.com/episodes/241-simple-omniauth-revised, 2019-08-07
    def authn_user!
      if Rails.env.production? || Rails.env.staging?
        user = User.find_for_shibboleth_oauth(request, nil)
        session[:user_id] = user.id
      else
        authenticate_user!
      end
      session[:cookie_version] = Rails.application.config.quartermaster_cookie_version
    end
    helper_method :auth

    def current_ability
      @current_ability ||= Ability.new(curr_user, request.remote_ip)
    end

    def curr_user
      if Rails.env.production? || Rails.env.staging?
        if session[:cookie_version] == Rails.application.config.quartermaster_cookie_version && session[:user_id]
          @current_user ||= User.find(session[:user_id])
        end
        return @current_user
      else
        return current_user
      end
    end
    helper_method :curr_user

end
