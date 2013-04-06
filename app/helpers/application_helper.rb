module ApplicationHelper
  
  # Helper methods to make Devise Login work on other pages, i.e. in the navbar
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  # END Helpers for Devise Login

end
