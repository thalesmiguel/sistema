$(document).on('turbolinks:load', function(){
  carrega_datatable("uniformes","uniforme", ["nome","sexo","created_at","updated_at"], []);

  $(document).off("dblclick", "#uniformes-table tr[id^=uniforme]")
  $(document).on("dblclick", "#uniformes-table tr[id^=uniforme]", function(){
    var id = $(this).attr("id");
    var url = "/uniformes/" + id.replace("uniforme_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
