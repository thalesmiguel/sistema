$(document).on('turbolinks:load', function(){
  carrega_datatable_id_automatico("#clientes-table", ".cliente-form", ".excluir-cliente", [], [0,1,2,3,4,5,6,7]);

  $(document).on("dblclick", "#clientes-table tr[id^=cliente]", function(){
    var id = $(this).attr("id");
    var url = "/clientes/" + id.replace("cliente_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })

});
