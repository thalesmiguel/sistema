$(document).on('turbolinks:load', function(){
  var campos = ["nome"];
  carrega_datatable_filtro("patrocinadores","patrocinador", campos, []);

  $(document).off("dblclick", "#patrocinadores-table tr[id^=patrocinador]")
  $(document).on("dblclick", "#patrocinadores-table tr[id^=patrocinador]", function(){
    var id = $(this).attr("id");
    var url = "/patrocinadores/" + id.replace("patrocinador_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
