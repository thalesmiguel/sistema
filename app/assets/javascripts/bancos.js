$(document).on('turbolinks:load', function(){
  carrega_datatable("bancos","banco", ["codigo","nome"], []);

  $(document).off("dblclick", "#bancos-table tr[id^=banco]")
  $(document).on("dblclick", "#bancos-table tr[id^=banco]", function(){
    var id = $(this).attr("id");
    var url = "/bancos/" + id.replace("banco_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
