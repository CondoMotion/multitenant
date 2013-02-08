Forum::Application.routes.draw do

  get '/', to: 'home#index', as: 'home', constraints: lambda { |r| r.subdomain.blank? || r.subdomain == 'www' }
  get '/pricing', to: 'home#pricing', as: 'pricing', constraints: lambda { |r| r.subdomain.blank? || r.subdomain == 'www' }
  get '/contact', to: 'home#contact', as: 'contact', constraints: lambda { |r| r.subdomain.blank? || r.subdomain == 'www' }
  get '/about', to: 'home#about', as: 'about', constraints: lambda { |r| r.subdomain.blank? || r.subdomain == 'www' }

  resources :pages do
    collection { post :sort }
  end
  resources :managers
  devise_for :users
  resources :sites
  resources :posts
  resources :memberships do
    collection do
      post 'batch_create_managers'
      post 'batch_create_residents'
    end
  end

  get '/edit', to: 'sites#edit', as: 'edit_site', constraints: lambda { |r| r.subdomain.present? || r.subdomain != 'www' } 

  get '/', to: 'pages#show', constraints: lambda { |r| r.subdomain.present? || r.subdomain != 'www' }
  get ':id', to: 'pages#show', as: :page, constraints: lambda { |r| r.subdomain.present? || r.subdomain != 'www' }
  delete ':id', to: 'pages#destroy', as: :page
  put ':id', to: 'pages#update'
  get ':id/edit', to: 'pages#edit', as: :edit_page

  root to: 'sites#index'
end
