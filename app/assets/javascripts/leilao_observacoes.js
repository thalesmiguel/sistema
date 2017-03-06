$(document).on('ready', () => {
  var campos = ["created_at","descricao", "ativo"];
  carrega_datatable_filtro("leilao_observacoes","leilao_observacao", campos);

  $(document).off("dblclick", "#leilao_observacoes-table tr[id^=leilao_observacao]")
  $(document).on("dblclick", "#leilao_observacoes-table tr[id^=leilao_observacao]", (e) => {
    var id = $(e.currentTarget).attr("id");

    var url = "leilao_observacoes/" + id.replace("leilao_observacao_", "") + "/editar"
    console.log(1,url);
    $.ajax({ type: "GET", url: url });
  });

});
