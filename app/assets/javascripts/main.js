$(document).on('turbolinks:load', function(){
  // $('.modal-trigger').leanModal();

  $(".button-collapse").sideNav();
  // $('select').material_select();
  $('.collapsible').collapsible();
  // $(".dropdown-button").dropdown();
  $('ul.tabs').tabs();
  Waves.displayEffect()
  // Materialize.updateTextFields();


  $(document).ajaxStart(function() { Pace.restart(); });
  // $(".button-collapse").sideNav();
  // $("select[required]").css({display: "block", height: 0, padding: 0, width: 0, position: 'absolute'});

  // Mouse Trap
  // Mousetrap.bind(['command+p', 'ctrl+p'], function(e) {
  //   $('a[data-target="impressao_modal"]').click();
  //   return false;
  // });

  // valida_formulario();
  // limita_text_area();


});

// Material Design Alert
$(function() {
  $.rails.allowAction = function(link) {
    if (!link.attr('data-confirm')) {
      return true;
    }
    $.rails.showConfirmDialog(link);
    return false;
  };

  $.rails.confirmed = function(link) {
    link.removeAttr('data-confirm');
    return link.trigger('click.rails');
  };

  $.rails.showConfirmDialog = function(link) {
    var html, message;
    message = link.attr('data-confirm');
    html = "<div id=\"modal1\" class=\"modal\" style=\"z-index: 1003; width: 30%; display: block; opacity: 1; transform: scaleX(1); top: 10%;\"> <div class=\"modal-content\"><h4>Atenção</h4><p>" + message + "</p></div><div class=\"modal-footer\"><a class=\"modal-action modal-close btn danger-color waves-effect waves-light confirm\">Confirmar</a><a class=\"modal-action modal-close waves-effect waves-light btn secondary-color close m-r-5\">Cancelar</a></div></div>";
    $('body').append(html);
    $('#modal1').openModal({
      complete: function() {
        $('#modal1').remove();
      }
    });
    return $('#modal1 .confirm').on('click', function() {
      return $.rails.confirmed(link);
    });
    return $('#modal1 .close').on('click', function() {
      return $('#modal1').closeModal();
    });
  };
});

function valida_formulario() {
  //Validação dos botôes dos formulários
  $('form').each(function(){$(this).data('serialized', $(this).serialize())})
    .on('change input', function(){
      $(this)
        .find('input:submit, button:submit, input:reset, button:reset')
        .prop('disabled', $(this).serialize() == $(this).data('serialized'));
    })
      .find('input:submit, button:submit, input:reset, button:reset')
      .prop('disabled', true);

    $('form').bind('reset', function() {
      $(this).find('input:submit, button:submit, input:reset, button:reset').prop('disabled', true);
    });

  // Jquery Validation
  // $.validator.setDefaults({
  //   onkeyup: false,
  //   errorClass: 'invalid',
  //   validClass: 'valid',
  //   submitHandler: function(form) {
  //     $(form).find("input[type='submit']").prop('disabled', true);
  //     $(form).find("button[type='submit']").addClass("disabled");
  //     $(form).find("button[type='submit']").prop('disabled', true);
  //     form.submit();
  //   },
  //   errorPlacement: function(error, element) {
  //     error.insertAfter($(element).siblings('label'));
  //   }
  // });
  //
  // $(document).ready(function(){
  // 	$("form[class~='validate']").each(function(){
  // 		$(this).validate();
  // 	});
  // });
  //
  // jQuery.extend(jQuery.validator.messages, {
  //   required: "Campo obrigatório.",
  //   remote: "Por favor, corrija o campo.",
  //   email: "Por favor, digite um endereço de e-mail válido.",
  //   url: "Por favor, digite uma URL válida.",
  //   date: "Por favor, digite uma data válida.",
  //   dateISO: "Por favor, digite uma data válida (ISO).",
  //   number: "Por favor, digite um número válido.",
  //   digits: "Por favor, digite apenas números.",
  //   creditcard: "Por favor, digite um número de cartão válido.",
  //   equalTo: "Por favor, digite o mesmo valor novamente.",
  //   accept: "Por favor, digite um valor com extensão válida.",
  //   maxlength: jQuery.validator.format("Por favor, não digite mais do que {0} caracteres."),
  //   minlength: jQuery.validator.format("Por favor, digite pelo menos {0} caracteres."),
  //   rangelength: jQuery.validator.format("Por favor, digite entre {0} e {1} caracteres."),
  //   range: jQuery.validator.format("Por favor, digite entre {0} e {1} caracteres."),
  //   max: jQuery.validator.format("Por favor, digite um valor MENOR ou igual a {0}."),
  //   min: jQuery.validator.format("Por favor, digite um valor MAIOR ou igual a {0}.")
  // });
};

// text_area
function limita_text_area() {
  $('.limita-text-area').bind('change keyup', function(event) {
    //Option 1: Limit to # of rows in textarea
    rows = $(this).attr('rows');

    var value = '';
    var splitval = $(this).val().split("\n");

    for(var a=0;a<rows && typeof splitval[a] != 'undefined';a++) {
      if(a>0) value += "\n";
      value += splitval[a];
    }
    $(this).val(value);
  });
};
// text_area

function carrega_datatable(id_tabela, classe_formulario, classe_excluir, colunas_nao_clicaveis) {
  var tabela = $(id_tabela).dataTable({
    processing: true,
    serverSide: true,
    ajax: $(id_tabela).data('source'),
    pagingType: "full_numbers",
    autoWidth: false,
    columnDefs: [ { orderable: false, targets: colunas_nao_clicaveis } ],
    language: {
      sUrl: "datatable_i18n"
    },
    drawCallback: function( settings ) {
      $('.paginate_button').addClass("waves-effect");
      $('select').material_select();
      // $('.tooltipped').tooltip({delay: 1000});
    },
  });

  $(document).on('ajax:complete', classe_formulario, function(){
    tabela.fnDraw();
    // tabela.fnStandingRedraw();
  });
  $(document).on('ajax:complete', classe_excluir, function(){
    tabela.fnDraw();
  });
};

function carrega_datatable_id_automatico(id_tabela, classe_formulario, classe_excluir, colunas_nao_clicaveis, calunas_com_dados) {

  var lista_calunas_com_dados = []
  $.each(calunas_com_dados, function( index, value ) {
    lista_calunas_com_dados.push({data: value.toString()})
  });

  var tabela = $(id_tabela).dataTable({
    processing: true,
    serverSide: true,
    ajax: $(id_tabela).data('source'),
    pagingType: "full_numbers",
    autoWidth: false,
    columnDefs: [ { orderable: false, targets: colunas_nao_clicaveis } ],
    columns: lista_calunas_com_dados,
    language: {
      sUrl: "datatable_i18n"
    },
    drawCallback: function( settings ) {
      $('.paginate_button').addClass("waves-effect");
      $('select').material_select();
      // $('.tooltipped').tooltip({delay: 1000});
    },
  });

  $(document).on('ajax:complete', classe_formulario, function(){
    tabela.fnDraw();
    // tabela.fnStandingRedraw();
  });
  $(document).on('ajax:complete', classe_excluir, function(){
    tabela.fnDraw();
  });
};

function mascaras() {
  $(".data").unmask();
  $(".cpf").unmask();
  $(".cnpj").unmask();
  $(".rg").unmask();
  $(".cep").unmask();

  $(".data").mask("99/99/9999", {placeholder: " "});
  $(".cpf").mask("999.999.999-**", {placeholder: " "});
  $(".cnpj").mask("99.999.999/9999-**", {placeholder: " "});
  $(".rg").mask("99.999.999-*", {placeholder: " "});
  $(".cep").mask("99.999-999", {placeholder: " "});
}

function cidades_dropdown(){
  return $(document).on('change', '#endereco_estado', function(evt) {
    return $.ajax('cidades/update_cidades', {
      format: 'js',
      type: 'GET',
      dataType: 'script',
      data: {
        estado_id: $("#endereco_estado option:selected").val()
      },
      error: function(jqXHR, textStatus, errorThrown) {
        // return console.log("AJAX Error: " + textStatus);
      },
      success: function(data, textStatus, jqXHR) {
        // return console.log("Dynamic state select OK!");
      }
    });
  });
}
