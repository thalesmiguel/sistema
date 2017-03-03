$(document).on('ready', function(){
  var campos = ["modelo","ano","placa","combustivel","ocupantes","media","disponivel_viagem"];
  carrega_datatable_filtro("veiculos","veiculo", campos, []);

  $(document).off("dblclick", "#veiculos-table tr[id^=veiculo]")
  $(document).on("dblclick", "#veiculos-table tr[id^=veiculo]", function(){
    var id = $(this).attr("id");
    var url = "/veiculos/" + id.replace("veiculo_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
  });

});
