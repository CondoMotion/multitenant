Forum::Application.routes.draw do

  get '/', to: 'home#index', as: 'home', constraints: lambda { |r| r.subdomain.blank? || r.subdomain == 'www' }
  get '/pricing', to: 'home#pricing', as: 'pricing', constraints: lambda { |r| r.subdomain.blank? || r.subdomain == 'www' }
  get '/contact', to: 'home#contact', as: 'contact', constraints: lambda { |r| r.subdomain.blank? || r.subdomain == 'www' }

  get '/', to: 'pages#show', constraints: lambda { |r| r.subdomain.present? || r.subdomain != 'www' }
  get '/edit', to: 'sites#edit', as: 'edit_site', constraints: lambda { |r| r.subdomain.present? || r.subdomain != 'www' } 

  resources :pages do
    collection { post :sort }
  end
  devise_for :users
  resources :sites
  resources :posts

  root to: 'sites#index'
end
