$(document).on('turbolinks:load', function(){
  $(document).off("dblclick", "#telefones-table tr[id^=telefone]")
  $(document).on("dblclick", "#telefones-table tr[id^=telefone]", function(){
    var id = $(this).attr("id");
    var cliente = $("#telefones-table").data('cliente-telefone')
    var url = "clientes/" + cliente + "/telefones/" + id.replace("telefone_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });
});
