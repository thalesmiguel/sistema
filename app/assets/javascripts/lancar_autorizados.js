$(document).on('turbolinks:load', function(){
  // carrega_datatable_id_automatico("#lancar_autorizados-table", ".lancar_autorizado-form", ".excluir-lancar_autorizado", [], [0,1,2,3,4]);

  $(document).on("dblclick", "#lancar_autorizados-table tr[id^=lancar_autorizado]", function(){
    var id = $(this).attr("id");
    var cliente = $("#lancar_autorizados-table").data('cliente-lancar_autorizado')

    var url = "clientes/" + cliente + "/lancar_autorizados/" + id.replace("lancar_autorizado_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })

  $(document).on("change", "#lancar_autorizado_procuracao", function(){
    $("#salvar-cliente-lancar_autorizado").prop("disabled", false);
  })
});
