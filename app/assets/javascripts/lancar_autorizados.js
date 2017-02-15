$(document).on('turbolinks:load', function(){
  $(document).off("dblclick", "#lancar_autorizados-table tr[id^=lancar_autorizado]")
  $(document).on("dblclick", "#lancar_autorizados-table tr[id^=lancar_autorizado]", function(){
    var id = $(this).attr("id");
    var cliente = $("#lancar_autorizados-table").data('cliente-lancar_autorizado')
    var url = "clientes/" + cliente + "/lancar_autorizados/" + id.replace("lancar_autorizado_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  $(document).off("change", "#lancar_autorizado_procuracao")
  $(document).on("change", "#lancar_autorizado_procuracao", function(){
    $("#salvar-cliente-lancar_autorizado").prop("disabled", false);
  })

  $(document).off("click", "a[href='#cliente-lancar_autorizados'].standby")
  $(document).on("click", "a[href='#cliente-lancar_autorizados'].standby", function(){
    var campos = ["nome","cpf","tem_procuracao","observacao","ativo"];
    carrega_datatable_filtro("lancar_autorizados","lancar_autorizado", campos, []);
    $(this).removeClass("standby");
  })
});
