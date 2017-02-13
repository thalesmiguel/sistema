$(document).on('turbolinks:load', function(){
  $('ul.tabs').tabs();

  let campos = ["ativo","cadastro_tipo","cpf_cnpj","nome","apelido","ficticio","cidade_nome","estado_sigla"];
  carrega_datatable_filtro("clientes","cliente", campos, []);

  $(document).off("dblclick", "#clientes-table tr[id^=cliente]")
  $(document).on("dblclick", "#clientes-table tr[id^=cliente]", function(){
    var id = $(this).attr("id");
    var url = "/clientes/" + id.replace("cliente_", "") + "/editar"
    $.ajax({ type: "GET", url: url });
    $("a[href='#cliente-enderecos'],a[href='#cliente-telefones'],a[href='#cliente-emails'],a[href='#cliente-fazendas'],a[href='#cliente-cliente_bancos'],a[href='#cliente-referencias'],a[href='#cliente-lancar_autorizados'],a[href='#cliente-racas'],a[href='#cliente-empresas'],a[href='#cliente-alertas'],a[href='#cliente-contatos'],a[href='#cliente-relatorios']").addClass('standby');
  });


  $(document).off("click", "a[href='#cliente-pesquisar']")
  $(document).on("click", "a[href='#cliente-pesquisar']", function(){
    $("#clientes-table").dataTable().fnDraw();
    $("#cliente-dados-adicionais").addClass("hide");
  });

  $(document).off("click", "a[href='#cliente-visualizar'], a[href='#cliente-alertas'], a[href='#cliente-contatos'], a[href='#cliente-relatorios']")
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
    } else {
      cpf_cnpj.removeClass("cpf").addClass("cnpj");
      label.html("CNPJ")
    };
    mascaras();
  });
};
