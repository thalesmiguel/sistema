$(document).on('turbolinks:load', function(){
  carrega_datatable_id_automatico("#alertas-table", ".alerta-form", ".excluir-alerta", [], [0,1,2,3,4,5]);

  $(document).on("dblclick", "#alertas-table tr[id^=alerta]", function(){
    var id = $(this).attr("id");
    var cliente = $("#alertas-table").data('cliente-alerta')

    var url = "clientes/" + cliente + "/alertas/" + id.replace("alerta_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })
});
