// $(document).on('turbolinks:load', function(){
//   carrega_datatable("#bancos-table", ".banco-form", ".excluir-banco", [2]);
// });

$(document).on('turbolinks:load', function(){
  carrega_datatable_id_automatico("#bancos-table", ".banco-form", ".excluir-banco", [], [0,1]);

  $(document).on("dblclick", "#bancos-table tr[id^=banco]", function(){
    var id = $(this).attr("id");

    var url = "/bancos/" + id.replace("banco_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })
});
