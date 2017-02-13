$(document).on('turbolinks:load', function(){
  var campos = ["nome","created_at","updated_at"];
  carrega_datatable_filtro("funcoes","funcao", campos, []);

  $(document).off("dblclick", "#funcoes-table tr[id^=funcao]")
  $(document).on("dblclick", "#funcoes-table tr[id^=funcao]", function(){
    var id = $(this).attr("id");
    var url = "/funcoes/" + id.replace("funcao_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
