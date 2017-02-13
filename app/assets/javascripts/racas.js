$(document).on('turbolinks:load', function(){
  var campos = ["nome","especie"];
  carrega_datatable_filtro("racas","raca", campos, []);

  $(document).off("dblclick", "#racas-table tr[id^=raca]")
  $(document).on("dblclick", "#racas-table tr[id^=raca]", function(){
    var id = $(this).attr("id");
    var url = "/racas/" + id.replace("raca_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
