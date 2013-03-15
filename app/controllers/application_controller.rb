class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    def authenticate_admin!
      if !current_user.admin?
        redirect_to home_path
    end
  end
end
