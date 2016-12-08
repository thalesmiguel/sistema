$(document).on('turbolinks:load', function(){
  carrega_datatable("#clientes-table", ".cliente-form", ".excluir-cliente", []);

  $("#bozo").on("click", function(){
    $.ajax({
      type: "GET",
      url: "/clientes/1/editar"
    });
  })

});
