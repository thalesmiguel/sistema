$(document).on('turbolinks:load', function(){
  carrega_datatable_id_automatico("#clientes-table", ".cliente-form", ".excluir-cliente", [], [0,1,2,3,4,5,6,7]);

  $(document).on("dblclick", "#clientes-table tr[id^=cliente]", function(){
    var id = $(this).attr("id");
    var url = "/clientes/" + id.replace("cliente_", "") + "/editar"

    $.ajax({
      type: "GET",
      url: url
    });
  });

  $(document).on("click", "a[href='#cliente-pesquisar']", function(){
    $("#clientes-table").dataTable().fnDraw();
    $("#cliente-dados-adicionais").addClass("hide");
  });

  $(document).on("click", "a[href='#cliente-visualizar'], a[href='#cliente-alertas'], a[href='#cliente-contatos'], a[href='#cliente-relatorios']", function(){
    $("#cliente-dados-adicionais").removeClass("hide");
  });

});

function altera_mascara_cpf_cnpj(){
  $("#cliente_pessoa_tipo").on("change", function(){
    var selecionado = $('#cliente_pessoa_tipo option:selected').text();
    var cpf_cnpj = $("#cliente_cpf_cnpj");
    var label = $("label[for='cliente_cpf_cnpj']");

    if ( selecionado == "Física" ) {
      cpf_cnpj.removeClass("cnpj").addClass("cpf");
      label.html("CPF")
    } else  {
      cpf_cnpj.removeClass("cpf").addClass("cnpj");
      label.html("CNPJ")
    };
    mascaras();
  });
}
