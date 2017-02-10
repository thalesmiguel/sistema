$(document).on('turbolinks:load', function(){
  // carrega_datatable_id_automatico_sem_controles("#alerta_comentarios-table", ".alerta_comentario-form", ".excluir-alerta_comentario", [], [0,1]);

  $(document).off("dblclick", "#alerta_comentarios-table tr[id^=alerta_comentario]")
  $(document).on("dblclick", "#alerta_comentarios-table tr[id^=alerta_comentario]", function(){
    var id = $(this).attr("id");
    var alerta = $("#alerta_comentarios-table").data('alerta-alerta_comentario')

    var url = "alertas/" + alerta + "/alerta_comentarios/" + id.replace("alerta_comentario_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  });

  $(document).on("ajax:complete", "form[id*='alerta_comentario']", function(){
    $("#alertas-table").dataTable().fnDraw();
  })
});
