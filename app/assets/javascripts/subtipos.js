$(document).on('turbolinks:load', function(){
  var campos = ["id","nome"];
  carrega_datatable_filtro("subtipos","subtipo", campos, []);

  $(document).off("dblclick", "#subtipos-table tr[id^=subtipo]")
  $(document).on("dblclick", "#subtipos-table tr[id^=subtipo]", function(){
    var id = $(this).attr("id");
    var url = "/subtipos/" + id.replace("subtipo_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
