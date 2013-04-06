class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
    # Tweak this a bit so that it logs if they are forcing one of the admin pages.
    # Also, might want to throw a flash message? Saying that it is only for admins? Or maybe not...
    
    def authenticate_admin!
      if current_user and !current_user.admin?
        redirect_to events_path
    end
  end
end
