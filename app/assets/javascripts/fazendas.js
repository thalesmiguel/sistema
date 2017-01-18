$(document).on('turbolinks:load', function(){
  $(document).on("dblclick", "#fazendas-table tr[id^=fazenda]", function(){
    var id = $(this).attr("id");
    var cliente = $("#fazendas-table").data('cliente-fazenda')
    var url = "clientes/" + cliente + "/fazendas/" + id.replace("fazenda_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });
  cidades_dropdown('fazenda');
});
