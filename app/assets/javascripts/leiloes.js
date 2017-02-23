$(document).on('turbolinks:load', () => {
  let campos = ["nome","recinto","cidade_nome","estado_sigla","data_inicio"];
  carrega_datatable_filtro("leiloes","leilao", campos, []);

  $(document).off("dblclick", "#leiloes-table tr[id^=leilao]")
  $(document).on("dblclick", "#leiloes-table tr[id^=leilao]", (e) => {
    let id = $(e.currentTarget).attr("id");
    let url = "/leiloes/" + id.replace("leilao_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  cidades_dropdown('leilao');
});
