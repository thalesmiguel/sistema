$(document).on('turbolinks:load', function(){
  carrega_datatable_id_automatico("#cliente_bancos-table", ".cliente_banco-form", ".excluir-cliente_banco", [], [0,1,2,3,4,5,6,7,8]);

  $(document).on("dblclick", "#cliente_bancos-table tr[id^=cliente_banco]", function(){
    var id = $(this).attr("id");
    var cliente = $("#cliente_bancos-table").data('cliente-cliente_banco')

    var url = "clientes/" + cliente + "/cliente_bancos/" + id.replace("cliente_banco_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })

  cidades_dropdown('cliente_banco');
});


$(document).on("dblclick", "#cliente_banco_banco_codigo", function(){
  var url = "/bancos/lista_bancos"
  $.ajax({
    type: "GET",
    url: url,
    success: function(){
      carrega_datatable_id_automatico("#bancos-table", ".banco-form", ".excluir-banco", [], [0,1]);
    }
  });
});
