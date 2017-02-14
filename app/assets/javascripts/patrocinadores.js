$(document).on('turbolinks:load', () => {
  var campos = ["nome"];
  carrega_datatable_filtro("patrocinadores","patrocinador", campos, []);

  $(document).off("dblclick", "#patrocinadores-table tr[id^=patrocinador]")
  $(document).on("dblclick", "#patrocinadores-table tr[id^=patrocinador]", (e) => {
    var id = $(e.currentTarget).attr("id");
    var url = "/patrocinadores/" + id.replace("patrocinador_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
