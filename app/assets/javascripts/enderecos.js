$(document).on('turbolinks:load', function(){
  $(document).on("dblclick", "#enderecos-table tr[id^=endereco]", function(){
    var id = $(this).attr("id");
    var cliente = $("#enderecos-table").data('cliente-endereco')
    var url = "clientes/" + cliente + "/enderecos/" + id.replace("endereco_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  cidades_dropdown('endereco');
});
