Rails.application.routes.draw do

  root to: 'clientes#index'

  # Devise
  devise_for :users, controllers: { registrations: "registrations" }
  resources :users, only: [:index, :destroy]
  devise_scope :user do
    get "users/:id/edit" => "registrations#edit", as: 'edit_user'
    patch "users/:id" => "registrations#update"
  end
  # Devise

  get 'cidades/update_cidades', as: 'update_cidades'
  get 'bancos/lista_bancos', as: 'lista_bancos'

  scope path_names: { new: "novo", edit: "editar" } do
    resources :estados, except: [:show]
    resources :cidades, except: [:show]
    resources :bancos, except: [:show]
    resources :funcoes, except: [:show]
    resources :uniformes, except: [:show]
    resources :veiculos, except: [:show]

    put 'clientes/:id/altera_status', to: 'clientes#altera_status', as: 'altera_status_cliente'
    resources :clientes, except: [:show] do
      resources :enderecos, except: [:show]
      resources :telefones, except: [:show]
      resources :emails, except: [:show]
      resources :fazendas, except: [:show]
      resources :cliente_bancos, except: [:show]
      resources :referencias, except: [:show]
      resources :lancar_autorizados, except: [:show]
      put 'lancar_autorizados/:id/deleta_procuracao', to: 'lancar_autorizados#deleta_procuracao', as: 'deleta_procuracao'
      resources :empresas, except: [:show]
      resources :alertas, except: [:show]
    end
    resources :alertas, except: [:show] do
      resources :alerta_comentarios, except: [:show]
    end

  end

  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    get 'datatable_i18n', to: 'datatables#datatable_i18n'
  end
  # get '*path', to: redirect("/#{I18n.default_locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.default_locale}/" }
  # get '', to: redirect("/#{I18n.default_locale}")

end
