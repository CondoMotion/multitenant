class ApplicationController < ActionController::Base
  protect_from_forgery
  around_filter :scope_current_company
  layout :layout_by_resource

  def layout_by_resource
    if request.subdomain.present? && request.subdomain != "www"
      if devise_controller?
        Site.unscoped.find_by_subdomain!(request.subdomain).layout
      else
        case controller_name
        when 'pages', 'posts', 'devise'
          Site.unscoped.find_by_subdomain!(request.subdomain).layout
        when 'sites'
          if action_name == 'show'
            Site.unscoped.find_by_subdomain!(request.subdomain).layout
          else
            'application'
          end
        else
          'application'
        end
      end
    else
      'application'
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
    case controller_name
    when 'sites', 'pages', 'posts'
      if action_name == 'show'
        if request.subdomain.present? && request.subdomain != "www"
          Site.unscoped.find_by_subdomain!(request.subdomain).company 
        end
      else
        if current_user
          Company.find(current_user.company_id)
        else
          nil
        end
      end  
    else
      if current_user
        Company.find(current_user.company_id)
      elsif devise_controller? && request.subdomain.present? && request.subdomain != "www"
        Site.unscoped.find_by_subdomain!(request.subdomain).company
      else
        nil
      end
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

  def after_sign_in_path_for(resource_or_scope)
    if request.subdomain.present? && request.subdomain != "www"
      root_path
    else
      sites_path
    end
  end
end
