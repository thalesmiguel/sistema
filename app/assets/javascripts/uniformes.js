$(document).on('turbolinks:load', function(){
  var campos = ["nome","sexo","created_at","updated_at"];
  carrega_datatable_filtro("uniformes","uniforme", campos, []);

  $(document).off("dblclick", "#uniformes-table tr[id^=uniforme]")
  $(document).on("dblclick", "#uniformes-table tr[id^=uniforme]", function(){
    var id = $(this).attr("id");
    var url = "/uniformes/" + id.replace("uniforme_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
