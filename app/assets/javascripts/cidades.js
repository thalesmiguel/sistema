$(document).on('turbolinks:load', function(){
  carrega_datatable("cidades","cidade", ["nome","estado_sigla","created_at","created_by","updated_at","updated_by"], [3,5]);

  $(document).on("dblclick", "#cidades-table tr[id^=cidade]", function(){
    var id = $(this).attr("id");
    var url = "/cidades/" + id.replace("cidade_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
