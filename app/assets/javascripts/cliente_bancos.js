$(document).on('turbolinks:load', function(){
  $(document).off("dblclick", "#cliente_bancos-table tr[id^=cliente_banco]")
  $(document).on("dblclick", "#cliente_bancos-table tr[id^=cliente_banco]", function(){
    var id = $(this).attr("id");
    var cliente = $("#cliente_bancos-table").data('cliente-cliente_banco')
    var url = "clientes/" + cliente + "/cliente_bancos/" + id.replace("cliente_banco_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  $(document).off("dblclick", "#cliente_banco_banco_codigo")
  $(document).on("dblclick", "#cliente_banco_banco_codigo", function(){
    var url = "/bancos/lista_bancos"
    $.ajax({ type: "GET", url: url,
      success: function(){
        carrega_datatable("bancos","banco", ["codigo","nome"], []);
      }
    });
  });

  cidades_dropdown('cliente_banco');
});
