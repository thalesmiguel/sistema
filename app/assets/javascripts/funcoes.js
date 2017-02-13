$(document).on('turbolinks:load', function(){
  carrega_datatable("funcoes","funcao", ["nome","created_at","updated_at"], []);

  $(document).off("dblclick", "#funcoes-table tr[id^=funcao]")
  $(document).on("dblclick", "#funcoes-table tr[id^=funcao]", function(){
    var id = $(this).attr("id");
    var url = "/funcoes/" + id.replace("funcao_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
