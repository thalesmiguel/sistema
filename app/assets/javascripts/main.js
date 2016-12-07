$(document).on('turbolinks:load', function(){
  // $('.modal-trigger').leanModal();

  $(".button-collapse").sideNav();
  $('select').material_select();
  $('.collapsible').collapsible();
  $(".dropdown-button").dropdown();
  $('.tooltipped').tooltip({delay: 1000});
  $('ul.tabs').tabs();
  Waves.displayEffect()
  Materialize.updateTextFields();


  $(document).ajaxStart(function() { Pace.restart(); });
  // $(".button-collapse").sideNav();
  // $("select[required]").css({display: "block", height: 0, padding: 0, width: 0, position: 'absolute'});

  // Mouse Trap
  // Mousetrap.bind(['command+p', 'ctrl+p'], function(e) {
  //   $('a[data-target="impressao_modal"]').click();
  //   return false;
  // });

  valida_formulario();
  limita_text_area();
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
}

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
}
// text_area
