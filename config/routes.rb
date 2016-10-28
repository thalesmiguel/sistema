Rails.application.routes.draw do
  # Isso é fácil, está explicado na documentação oficial. Vai ficar mais ou menos assim:
  # resources :usuarios, path_names: { new: "novo", edit: "editar" }

  # Ou se você quiser pode alterar vários de uma vez usando scope:
  #
  # scope path_names: { new: "novo", edit: "editar" } do
  #   # seus resources
  # end
end
