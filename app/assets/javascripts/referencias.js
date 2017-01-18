$(document).on('turbolinks:load', function(){
  $(document).on("dblclick", "#referencias-table tr[id^=referencia]", function(){
    var id = $(this).attr("id");
    var cliente = $("#referencias-table").data('cliente-referencia')
    var url = "clientes/" + cliente + "/referencias/" + id.replace("referencia_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });
});
