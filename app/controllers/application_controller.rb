class ApplicationController < ActionController::Base
  protect_from_forgery
  around_filter :scope_current_company
  layout :layout_by_resource

  def layout_by_resource
    if ((['pages','posts'].include? controller_name) || (controller_name == 'sites' && action_name == 'show')) && current_site
      if action_name == 'edit'
        'dashboard'
      else
        current_site.layout
      end
    elsif ['sessions', 'registrations', 'passwords'].include? controller_name
      if request.subdomain.present? && request.subdomain != "www"
        current_site.layout
      else
        if action_name == "edit"
          'application'
        else
          'home'
        end
      end
    else
      'application'
    end
  end

private
  def on_site? 
    request.subdomain.present? && request.subdomain != "www"
  end
  helper_method :on_site?

  def current_site
    if request.subdomain.present? && request.subdomain != "www"
      Site.find_by_subdomain! request.subdomain
    else
      nil
    end
  end
  helper_method :current_site
  
  def current_company
    if ((['sites','pages','posts'].include? controller_name) && action_name == 'show') || (devise_controller? && request.subdomain.present? && request.subdomain != "www")
      Site.unscoped.find_by_subdomain!(request.subdomain).company
    elsif current_user
      Company.find(current_user.company_id)
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

  def after_sign_in_path_for(resource_or_scope)
    if request.subdomain.present? && request.subdomain != "www"
      root_path
    else
      sites_path
    end
  end
end
