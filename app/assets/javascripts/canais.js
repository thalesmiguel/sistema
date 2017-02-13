$(document).on('turbolinks:load', function(){
  var campos = ["nome"];
  carrega_datatable_filtro("canais","canal", campos, []);

  $(document).off("dblclick", "#canais-table tr[id^=canal]")
  $(document).on("dblclick", "#canais-table tr[id^=canal]", function(){
    var id = $(this).attr("id");
    var url = "/canais/" + id.replace("canal_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
