$(document).on('ready', () => {
  let campos = ["nome_contrato","razao_social","comissao_elite","comissao_corte","comissao_virtual","comissao_shopping"];
  carrega_datatable_filtro("leiloeiros","leiloeiro", campos, []);

  $(document).off("dblclick", "#leiloeiros-table tr[id^=leiloeiro]")
  $(document).on("dblclick", "#leiloeiros-table tr[id^=leiloeiro]", (e) => {
    let id = $(e.currentTarget).attr("id");
    let url = "/leiloeiros/" + id.replace("leiloeiro_", "") + "/editar"
    $.ajax({ type: "GET", url: url }).done( () => $('.materialboxed').materialbox());
  });

  cidades_dropdown('leiloeiro');
});
