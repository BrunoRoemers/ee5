Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Public pages
  get 'landing_page', to: 'landing_page#index'
  get 'model', to: 'model#index'

  # Enable authentication
  devise_for :users, path: '', path_names: {
    password: 'reset_password'
  }

  devise_scope :user do
    get 'reset_password', to: 'devise/passwords#new', as: :reset_password

    unauthenticated do # Routes when logged out
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    authenticated :user do # Routes apply when logged in
      root 'admin/dashboard#index', as: :authenticated_root
    end
  end

  authenticate do # Routes inside this block require a authenticated user
    get 'tv', to: 'tv/progress_table#index'
    namespace :tv do
      get 'progress_table', to: 'progress_table#index'
      get 'progress_animation', to: 'progress_animation#index'
      get 'data', to: 'data#index'
    end

    scope module: 'admin' do
      get 'dashboard', to: 'dashboard#index'

      get 'stays', to: 'stays#index'
      get 'stays/new'
      post 'stays/create'
      get 'stays/create', to: redirect('/stays/new')
      get 'stays/:id/edit', to: 'stays#edit', as: 'stays_edit'
      patch 'stays/:id/update', to: 'stays#update', as: 'stays_update'
      get 'stays/:id/update', to: redirect { |params| "/stays/#{params[:id]}/edit" }
      delete 'stays/:id/destroy', to: 'stays#destroy', as: 'stays_destroy'
      get 'stays/:id/destroy', to: redirect { |params| "/stays/#{params[:id]}/edit" }

      get 'people', to: 'people#index'
      get 'people/new'
      post 'people/create'
      get 'people/create', to: redirect('/people/new')
      get 'people/:id/edit', to: 'people#edit', as: 'people_edit'
      patch 'people/:id/update', to: 'people#update', as: 'people_update'
      get 'people/:id/update', to: redirect { |params| "/people/#{params[:id]}/edit" }
      delete 'people/:id/destroy', to: 'people#destroy', as: 'people_destroy'
      get 'people/:id/destroy', to: redirect { |params| "/people/#{params[:id]}/edit" }
    end
  end
end
