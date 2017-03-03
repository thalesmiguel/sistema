$(document).on('ready', function(){
  var campos = ["nome","estado_sigla","created_at","created_by","updated_at","updated_by"];
  carrega_datatable_filtro("cidades","cidade", campos, [3,5]);

  $(document).off("dblclick", "#cidades-table tr[id^=cidade]")
  $(document).on("dblclick", "#cidades-table tr[id^=cidade]", function(){
    var id = $(this).attr("id");
    var url = "/cidades/" + id.replace("cidade_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
