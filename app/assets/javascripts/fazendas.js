$(document).on('ready', function(){
  $(document).off("dblclick", "#fazendas-table tr[id^=fazenda]")
  $(document).on("dblclick", "#fazendas-table tr[id^=fazenda]", function(){
    var id = $(this).attr("id");
    var cliente = $("#fazendas-table").data('cliente-fazenda')
    var url = "clientes/" + cliente + "/fazendas/" + id.replace("fazenda_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });
  cidades_dropdown('fazenda');

  $(document).off("click", "a[href='#cliente-fazendas'].standby")
  $(document).on("click", "a[href='#cliente-fazendas'].standby", function(){
    var campos = ["nome","cidade_nome","estado_sigla","inscricao_estadual","cnpj_produtor","cnpj_fazenda","ativo","fazenda_vendas","fazenda_compras"];
    carrega_datatable_filtro("fazendas","fazenda", campos, []);
    $(this).removeClass("standby");
  })
});
