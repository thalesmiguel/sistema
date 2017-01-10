$(document).on('turbolinks:load', function(){
  carrega_datatable_id_automatico("#emails-table", ".email-form", ".excluir-email", [], [0,1,2,3,4,5,6]);

  $(document).on("dblclick", "#emails-table tr[id^=email]", function(){
    var id = $(this).attr("id");
    var cliente = $("#emails-table").data('cliente-email')

    var url = "clientes/" + cliente + "/emails/" + id.replace("email_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })
});
