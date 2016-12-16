$(document).on('turbolinks:load', function(){
  carrega_datatable_id_automatico("#enderecos-table", ".endereco-form", ".excluir-endereco", [], [0,1,2,3,4,5,6,7,8,9,10]);

  $(document).on("dblclick", "#enderecos-table tr[id^=endereco]", function(){
    var id = $(this).attr("id");
    var cliente = $("#enderecos-table").data('cliente-endereco')

    var url = "clientes/" + cliente + "/enderecos/" + id.replace("endereco_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })

  cidades_dropdown();
});
