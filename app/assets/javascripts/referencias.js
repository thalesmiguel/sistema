$(document).on('turbolinks:load', function(){
  $(document).off("dblclick", "#referencias-table tr[id^=referencia]")
  $(document).on("dblclick", "#referencias-table tr[id^=referencia]", function(){
    var id = $(this).attr("id");
    var cliente = $("#referencias-table").data('cliente-referencia')
    var url = "clientes/" + cliente + "/referencias/" + id.replace("referencia_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  $(document).off("click", "a[href='#cliente-referencias'].standby")
  $(document).on("click", "a[href='#cliente-referencias'].standby", function(){
    var campos = ["nome","telefone","observacao"];
    carrega_datatable_filtro("referencias","referencia", campos, []);
    $(this).removeClass("standby");
  })
});
