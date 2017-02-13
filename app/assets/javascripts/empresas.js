$(document).on('turbolinks:load', function(){
  $(document).off("dblclick", "#empresas-table tr[id^=empresa]")
  $(document).on("dblclick", "#empresas-table tr[id^=empresa]", function(){
    var id = $(this).attr("id");
    var cliente = $("#empresas-table").data('cliente-empresa')
    var url = "clientes/" + cliente + "/empresas/" + id.replace("empresa_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  cidades_dropdown('empresa');

  $(document).off("click", "a[href='#cliente-empresas']")
  $(document).on("click", "a[href='#cliente-empresas'].standby", function(){
    var campos = ["nome","cnpj","cargo","logradouro","cidade_nome","estado_nome","cep"];
    carrega_datatable_filtro("empresas","empresa", campos, []);
    $(this).removeClass("standby");
  })
});
