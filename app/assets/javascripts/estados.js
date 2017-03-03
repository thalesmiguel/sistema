$(document).on('ready', function(){
  var campos = ["nome","sigla","created_at","created_by","updated_at","updated_by"];
  carrega_datatable_filtro("estados","estado", campos, [3,5]);

  $(document).off("dblclick", "#estados-table tr[id^=estado]")
  $(document).on("dblclick", "#estados-table tr[id^=estado]", function(){
    var id = $(this).attr("id");
    var url = "/estados/" + id.replace("estado_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
