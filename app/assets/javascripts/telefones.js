$(document).on('turbolinks:load', function(){
  carrega_datatable_id_automatico("#telefones-table", ".telefone-form", ".excluir-telefone", [], [0,1,2,3,4,5,6,7,8,9,10]);

  $(document).on("dblclick", "#telefones-table tr[id^=telefone]", function(){
    var id = $(this).attr("id");
    var cliente = $("#telefones-table").data('cliente-telefone')

    var url = "clientes/" + cliente + "/telefones/" + id.replace("telefone_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })
});
