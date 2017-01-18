$(document).on('turbolinks:load', function(){
  $(document).on("dblclick", "#emails-table tr[id^=email]", function(){
    var id = $(this).attr("id");
    var cliente = $("#emails-table").data('cliente-email')
    var url = "clientes/" + cliente + "/emails/" + id.replace("email_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });
});
