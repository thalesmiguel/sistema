Rails.application.routes.draw do

  root to: 'estados#index'

  # Devise
  # devise_for :users, controllers: { sessions: 'users/sessions', registrations: "users/registrations" }
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:index, :destroy]
  devise_scope :user do
    get "users/:id/edit" => "registrations#edit", as: 'edit_user'
  end
  # Devise


  scope path_names: { new: "novo", edit: "editar" } do
    resources :estados, except: [:show]
    resources :cidades
  end

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get 'datatable_i18n', to: 'datatables#datatable_i18n'
  end
  # get '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  # get '', to: redirect("/#{I18n.default_locale}")

end
