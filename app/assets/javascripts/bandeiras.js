$(document).on('turbolinks:load', function(){
  var campos = ["nome","sigla"];
  carrega_datatable_filtro("bandeiras","bandeira", campos, []);

  $(document).off("dblclick", "#bandeiras-table tr[id^=bandeira]")
  $(document).on("dblclick", "#bandeiras-table tr[id^=bandeira]", function(){
    var id = $(this).attr("id");
    var url = "/bandeiras/" + id.replace("bandeira_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
