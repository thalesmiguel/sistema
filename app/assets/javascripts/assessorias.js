$(document).on('turbolinks:load', () => {
  let campos = ["nome"];
  carrega_datatable_filtro("assessorias","assessoria", campos, []);

  $(document).off("dblclick", "#assessorias-table tr[id^=assessoria]")
  $(document).on("dblclick", "#assessorias-table tr[id^=assessoria]", (e) => {
    let id = $(e.currentTarget).attr("id");
    let url = "/assessorias/" + id.replace("assessoria_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
