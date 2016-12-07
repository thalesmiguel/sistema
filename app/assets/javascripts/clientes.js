$(document).on('turbolinks:load', function(){
  var clientesTable = $('#clientes-table').dataTable({
    processing: true,
    serverSide: true,
    ajax: $('#clientes-table').data('source'),
    pagingType: "full_numbers",
    autoWidth: false,
    // columnDefs: [ { orderable: false, targets: [2,3,4,5,6] } ],
    language: {
      sUrl: "datatable_i18n"
    },
    drawCallback: function( settings ) {
      $('.paginate_button').addClass("waves-effect");
      $('select').material_select();
      $('.tooltipped').tooltip({delay: 1000});
    },
  });

  $(document).on('ajax:complete', ".cliente-form", function(){
    clientesTable.fnStandingRedraw();
  });
  $(document).on('ajax:complete', ".excluir-cliente", function(){
    clientesTable.fnStandingRedraw();
  });


  $("#bozo").on("click", function(){
    $.ajax({
      type: "GET",
      url: "/clientes/1/editar"
    });
  })

});
