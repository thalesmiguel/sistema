Rails.application.routes.draw do
  # Isso é fácil, está explicado na documentação oficial. Vai ficar mais ou menos assim:
  # resources :usuarios, path_names: { new: "novo", edit: "editar" }


  scope path_names: { new: "novo", edit: "editar" } do
    resources :estados
    resources :cidades
  end
end
