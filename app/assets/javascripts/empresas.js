$(document).on('turbolinks:load', function(){
  $(document).on("dblclick", "#empresas-table tr[id^=empresa]", function(){
    var id = $(this).attr("id");
    var cliente = $("#empresas-table").data('cliente-empresa')
    var url = "clientes/" + cliente + "/empresas/" + id.replace("empresa_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

  cidades_dropdown('empresa');
});
