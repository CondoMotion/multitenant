class ApplicationController < ActionController::Base
  protect_from_forgery
  #around_filter :scope_current_company
  layout :layout_by_resource

  def layout_by_resource
    if devise_controller?
      if request.subdomain.present? && request.subdomain != "www"
        Site.unscoped.find_by_subdomain!(request.subdomain).layout
      else
        "application"
      end
    elsif (controller_name == 'sites' && action_name == 'show')
      if request.subdomain.present? && request.subdomain != "www"
        Site.unscoped.find_by_subdomain!(request.subdomain).layout
      else
        "application"
      end
    elsif controller_name == 'posts'
      if request.subdomain.present? && request.subdomain != "www"
        Site.unscoped.find_by_subdomain!(request.subdomain).layout
      else
        "application"
      end
    elsif controller_name == 'pages'
      if request.subdomain.present? && request.subdomain != "www"
        Site.unscoped.find_by_subdomain!(request.subdomain).layout
      else
        "application"
      end
    else
      "application"
    end
  end

private

  def current_site
    if request.subdomain.present? && request.subdomain != "www"
      Site.find_by_subdomain! request.subdomain
    else
      nil
    end
  end
  helper_method :current_site
  
  def current_company
    if current_user
      Company.find(current_user.company_id)
    elsif request.subdomain.present? && request.subdomain != "www"
      Site.unscoped.find_by_subdomain!(request.subdomain).company
    else
      nil
    end
  end
  helper_method :current_company
  
  def scope_current_company
    if current_company
      Company.current_id = current_company.id
    else
      Company.current_id = nil
    end
    yield
  ensure
    Company.current_id = nil
  end
end
