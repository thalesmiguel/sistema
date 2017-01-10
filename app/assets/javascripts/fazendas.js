$(document).on('turbolinks:load', function(){
  carrega_datatable_id_automatico("#fazendas-table", ".fazenda-form", ".excluir-fazenda", [], [0,1,2,3,4,5,6,7,8]);

  $(document).on("dblclick", "#fazendas-table tr[id^=fazenda]", function(){
    var id = $(this).attr("id");
    var cliente = $("#fazendas-table").data('cliente-fazenda')

    var url = "clientes/" + cliente + "/fazendas/" + id.replace("fazenda_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })

  cidades_dropdown('fazenda');
});
