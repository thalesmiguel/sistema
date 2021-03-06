$(document).on('ready', function(){
  $(document).off("dblclick", "#emails-table tr[id^=email]")
  $(document).on("dblclick", "#emails-table tr[id^=email]", function(){
    var id = $(this).attr("id");
    var cliente = $("#emails-table").data('cliente-email')
    var url = "clientes/" + cliente + "/emails/" + id.replace("email_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  $(document).off("click", "a[href='#cliente-emails'].standby")
  $(document).on("click", "a[href='#cliente-emails'].standby", function(){
    var campos = ["email","contato","created_at","mala_direta","ativo","solicitacao_email","envio_contratos"];
    carrega_datatable_filtro("emails","email", campos, []);
    $(this).removeClass("standby");
  })
});
