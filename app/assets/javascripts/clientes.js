$(document).on('turbolinks:load', function(){
  $('ul.tabs').tabs();

  // Datatables
  let campos = ["ativo","cadastro_tipo","cpf_cnpj","nome","apelido","ficticio","cidade_nome","estado_sigla"];
  let yadcf_campos = []
  $.each(campos, function( index, value ) {
    yadcf_campos.push({column_number: index, filter_reset_button_text: false, style_class: 'browser-default', filter_default_label: 'Filtrar'})
  });
  let campos_sem_busca_ordenacao = []

  carrega_datatable("clientes","cliente", campos, campos_sem_busca_ordenacao, yadcf_campos);
  // Datatabes

  $(document).on("dblclick", "#clientes-table tr[id^=cliente]", function(){
    var id = $(this).attr("id");
    var url = "/clientes/" + id.replace("cliente_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
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
};
