$(document).on('turbolinks:load', function(){
  var campos = ["nome","data_inicio","data_fim"];
  carrega_datatable_filtro("leilao_eventos","leilao_evento", campos, []);

  $(document).off("dblclick", "#leilao_eventos-table tr[id^=leilao_evento]")
  $(document).on("dblclick", "#leilao_eventos-table tr[id^=leilao_evento]", function(){
    var id = $(this).attr("id");
    var url = "/leilao_eventos/" + id.replace("leilao_evento_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
