$(document).on('turbolinks:load', function(){
  // carrega_datatable_id_automatico("#empresas-table", ".empresa-form", ".excluir-empresa", [], [0,1,2,3,4,5,6]);

  $(document).on("dblclick", "#empresas-table tr[id^=empresa]", function(){
    var id = $(this).attr("id");
    var cliente = $("#empresas-table").data('cliente-empresa')

    var url = "clientes/" + cliente + "/empresas/" + id.replace("empresa_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  })

  cidades_dropdown('empresa');
});
