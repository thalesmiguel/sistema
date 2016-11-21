Rails.application.routes.draw do

  root 'estados#index'

  scope path_names: { new: "novo", edit: "editar" } do
    resources :estados, except: [:show]
    resources :cidades
  end
end
