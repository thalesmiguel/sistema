class DatatablesController < ApplicationController
  def datatable_i18n
      locale =   {
          "decimal" =>        "",
          "emptyTable" =>     "Dados não encontrados",
          "info" =>           "Mostrando registros _START_ ~ _END_ de _TOTAL_",
          "infoEmpty" =>      "Mostrando registros 0 ~ 0 de 0",
          "infoFiltered" =>   "(filtrado de _MAX_ registros totais)",
          "infoPostFix" =>    "",
          "thousands" =>      ",",
          "lengthMenu" =>     "Mostrar _MENU_",
          "loadingRecords" => "Carregando...",
          # "processing" =>     "<div class='progress secondary-color'> <div class='indeterminate'></div> </div>",
          "processing" =>     "<div class='preloader-wrapper big active'><div class='spinner-layer spinner-blue-only'><div class='circle-clipper left'><div class='circle'></div></div><div class='gap-patch'><div class='circle'></div></div><div class='circle-clipper right'><div class='circle'></div></div></div></div>",
          "search" =>         "Pesquisar:",
          "zeroRecords" =>    "Sem registros para mostrar",
          "paginate" => {
              "first" =>      "Primeiro",
              "last" =>       "Último",
              "next" =>       "Próximo",
              "previous" =>   "Anterior"
          },
          "aria" => {
              "sortAscending" =>  " => ative para ordenar a coluna de forma ascendente",
              "sortDescending" => " => ative para ordenar a coluna de forma descendente"
          }
      }
    render :json => locale
  end
end
