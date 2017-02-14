$(document).on('turbolinks:load', () => {
  var campos = ["nome"];
  carrega_datatable_filtro("assessorias","assessoria", campos, []);

  $(document).off("dblclick", "#assessorias-table tr[id^=assessoria]")
  $(document).on("dblclick", "#assessorias-table tr[id^=assessoria]", (e) => {
    var id = $(e.currentTarget).attr("id");
    var url = "/assessorias/" + id.replace("assessoria_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
