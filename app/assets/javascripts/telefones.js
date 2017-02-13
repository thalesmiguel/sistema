$(document).on('turbolinks:load', function(){
  $(document).off("dblclick", "#telefones-table tr[id^=telefone]")
  $(document).on("dblclick", "#telefones-table tr[id^=telefone]", function(){
    var id = $(this).attr("id");
    var cliente = $("#telefones-table").data('cliente-telefone')
    var url = "clientes/" + cliente + "/telefones/" + id.replace("telefone_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  $(document).off("click", "a[href='#cliente-telefones']")
  $(document).on("click", "a[href='#cliente-telefones'].standby", function(){
    var campos = ["tipo","ddi","ddd","numero","created_at","ramal","nome_contato","importancia","telemarketing","divulgar","ativo"];
    carrega_datatable_filtro("telefones","telefone", campos, []);
    $(this).removeClass("standby");
  })
});
