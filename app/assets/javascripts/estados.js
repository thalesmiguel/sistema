$(document).on('turbolinks:load', function(){
  carrega_datatable("estados","estado", ["nome","sigla","created_at","created_by","updated_at","updated_by"], [2,3,4,5]);

  $(document).on("dblclick", "#estados-table tr[id^=estado]", function(){
    var id = $(this).attr("id");
    var url = "/estados/" + id.replace("estado_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
