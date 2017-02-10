$(document).on('turbolinks:load', function(){
  // $('.modal-trigger').leanModal();

  $('select.yadcf-filter').material_select();
  $(".yadcf-filter.inuse").closest("th").addClass("bg-filter");
  // $('select').material_select();
  $(".button-collapse").sideNav();
  $('.collapsible').collapsible();
  // $(".dropdown-button").dropdown();
  // $('ul.tabs').tabs();
  Waves.displayEffect()
  // Materialize.updateTextFields();


  $(document).ajaxStart(function() { Pace.restart(); });
  $('html').on('click', function(){
    $(".yadcf-filter-wrapper").hide(200);
  })
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

function carrega_datatable_filtro(modelo, modelo_singular, campos, campos_sem_busca_ordenacao) {

  var lista_campos = []
  $.each(campos, function( index, value ) {
    lista_campos.push({data: value.toString()})
  });

  let yadcf_campos = []
  $.each(campos, function( index, value ) {
    yadcf_campos.push({column_number: index, filter_reset_button_text: false, style_class: 'browser-default', filter_default_label: 'Filtrar'})
  });

  var table = "#" + modelo + "-table"

  var tabela = $(table).DataTable({
    processing: true,
    serverSide: true,
    stateSave: true,
    ajax: $("#" + modelo + "-table").data('source'),
    columns: lista_campos,
    pagingType: "full_numbers",
    autoWidth: false,
    columnDefs: [
      { orderable: false, targets: campos_sem_busca_ordenacao },
      { searchable: false, targets: campos_sem_busca_ordenacao }
    ],
    language: { sUrl: "datatable_i18n" },
    drawCallback: function( settings ) {
      $('.paginate_button').addClass("waves-effect waves-light");
      $('.dataTables_length select' ).material_select();
      $(".datatables-hr-filter").on("click", function(){
        $(this).next(".yadcf-filter-wrapper").show(200);
        return false;
      });
      datatable_context_menu(table, tabela);
      yadcf.init(tabela, yadcf_campos);
      $(".yadcf-filter.inuse").closest("th").addClass("bg-filter");
      $(".yadcf-filter").not(".inuse").closest("th").removeClass("bg-filter");
      $("td:contains(verdadeiro)").html('<i class="material-icons secondary-color-text">check_box</i>');
      $("td:contains(falso)").html('<i class="material-icons secondary-color-text">check_box_outline_blank</i>');
    }
  });

  $(document).on('ajax:complete', "." + modelo_singular + "-form", function(){
    tabela.draw();
  });
};

function datatable_context_menu(table, tabela) {
  $(document).contextmenu({
    delegate: table + " td",
    menu: [
      {title: "Filtrar", cmd: "filter", uiIcon: "filter"},
      {title: "Remover Filtros", cmd: "nofilter", uiIcon: "nofilter"}
    ],
    select: function(event, ui) {
      var celltext = ui.target.text();
      var colvindex = ui.target.parent().children().index(ui.target);
      switch(ui.cmd){
        case "filter":
          tabela.column( colvindex ).search( celltext ).draw();
          let header = tabela.column( colvindex ).header();
          $(header).find(".yadcf-filter").addClass("inuse");
          break;
        case "nofilter":
          tabela.search('').columns().search('').draw();
          $(".yadcf-filter.inuse").removeClass("inuse");
          break;
      }
    },
    beforeOpen: function(event, ui) {
      var $menu = ui.menu,
          $target = ui.target,
          extraData = ui.extraData;
    }
  });
}

function carrega_datatable(modelo, modelo_singular, campos, campos_sem_busca_ordenacao) {

  var lista_campos = []
  $.each(campos, function( index, value ) {
    lista_campos.push({data: value.toString()})
  });

  var tabela = $("#" + modelo + "-table").DataTable({
    processing: true,
    serverSide: true,
    ajax: $("#" + modelo + "-table").data('source'),
    columns: lista_campos,
    pagingType: "full_numbers",
    autoWidth: false,
    columnDefs: [
      { orderable: false, targets: campos_sem_busca_ordenacao },
      { searchable: false, targets: campos_sem_busca_ordenacao }
    ],
    language: { sUrl: "datatable_i18n" },
    drawCallback: function( settings ) {
      $('.paginate_button').addClass("waves-effect waves-light");
      $('select').not('.yadcf-filter').material_select();
    }
  });

  $(document).on('ajax:complete', "." + modelo_singular + "-form", function(){
    tabela.draw();
  });
};

function carrega_datatable_sem_controles(modelo, modelo_singular, campos, campos_sem_busca_ordenacao) {

  var lista_campos = []
  $.each(campos, function( index, value ) {
    lista_campos.push({data: value.toString()})
  });

  var tabela = $("#" + modelo + "-table").DataTable({
    paging:    false,
    info:      false,
    searching: false,
    processing: true,
    serverSide: true,
    ajax: $("#" + modelo + "-table").data('source'),
    columns: lista_campos,
    pagingType: "full_numbers",
    autoWidth: false,
    columnDefs: [
      { orderable: false, targets: campos_sem_busca_ordenacao },
      { searchable: false, targets: campos_sem_busca_ordenacao }
    ],
    language: { sUrl: "datatable_i18n" },
    drawCallback: function( settings ) {
      $('.paginate_button').addClass("waves-effect waves-light");
      $('select').not('.yadcf-filter').material_select();
    }
  });

  $(document).on('ajax:complete', "." + modelo_singular + "-form", function(){
    tabela.draw();
  });
};

// function carrega_datatable_id_automatico(id_tabela, classe_formulario, classe_excluir, colunas_nao_clicaveis, colunas_com_dados) {
//
//   var lista_colunas_com_dados = []
//   $.each(colunas_com_dados, function( index, value ) {
//     lista_colunas_com_dados.push({data: value.toString()})
//   });
//
//   var tabela = $(id_tabela).dataTable({
//     processing: true,
//     serverSide: true,
//     ajax: $(id_tabela).data('source'),
//     pagingType: "full_numbers",
//     autoWidth: false,
//     columnDefs: [ { orderable: false, targets: colunas_nao_clicaveis } ],
//     columns: lista_colunas_com_dados,
//     language: {
//       sUrl: "datatable_i18n"
//     },
//     drawCallback: function( settings ) {
//       $('.paginate_button').addClass("waves-effect");
//       $('select').material_select();
//       // $('.tooltipped').tooltip({delay: 1000});
//     },
//   });
//
//   $(document).on('ajax:complete', classe_formulario, function(){
//     tabela.fnDraw();
//     // tabela.fnStandingRedraw();
//   });
//   $(document).on('ajax:complete', classe_excluir, function(){
//     tabela.fnDraw();
//   });
// };

// function carrega_datatable_id_automatico_sem_controles(id_tabela, classe_formulario, classe_excluir, colunas_nao_clicaveis, colunas_com_dados) {
//
//   var lista_colunas_com_dados = []
//   $.each(colunas_com_dados, function( index, value ) {
//     lista_colunas_com_dados.push({data: value.toString()})
//   });
//
//   var tabela = $(id_tabela).dataTable({
//     paging:   false,
//     ordering: true,
//     info:     false,
//     searching:   false,
//     processing: true,
//     serverSide: true,
//     ajax: $(id_tabela).data('source'),
//     pagingType: "full_numbers",
//     autoWidth: false,
//     columnDefs: [ { orderable: false, targets: colunas_nao_clicaveis } ],
//     columns: lista_colunas_com_dados,
//     language: {
//       sUrl: "datatable_i18n"
//     },
//     drawCallback: function( settings ) {
//       $('.paginate_button').addClass("waves-effect");
//       $('select').material_select();
//       // $('.tooltipped').tooltip({delay: 1000});
//     },
//   });
//
//   $(document).on('ajax:complete', classe_formulario, function(){
//     tabela.fnDraw();
//     // tabela.fnStandingRedraw();
//   });
//   $(document).on('ajax:complete', classe_excluir, function(){
//     tabela.fnDraw();
//   });
// };

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

function cidades_dropdown(model){
  return $(document).on('change', '#' + model + '_estado', function(evt) {
    return $.ajax('cidades/update_cidades', {
      format: 'js',
      type: 'GET',
      dataType: 'script',
      data: {
        estado_id: $("#" + model + "_estado option:selected").val(),
        model: model
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
