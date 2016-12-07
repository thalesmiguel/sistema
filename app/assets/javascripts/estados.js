$(document).on('turbolinks:load', function(){
  var estadosTable = $('#estados-table').dataTable({
    processing: true,
    serverSide: true,
    ajax: $('#estados-table').data('source'),
    pagingType: "full_numbers",
    autoWidth: false,
    columnDefs: [ { orderable: false, targets: [2,3,4,5,6] } ],
    language: {
      sUrl: "datatable_i18n"
    },
    drawCallback: function( settings ) {
      $('.paginate_button').addClass("waves-effect");
      $('select').material_select();
      $('.tooltipped').tooltip({delay: 1000});
    },
  });

  $(document).on('ajax:complete', ".estado-form", function(){
    estadosTable.fnStandingRedraw();
  });
  $(document).on('ajax:complete', ".excluir-estado", function(){
    estadosTable.fnStandingRedraw();
  });

});
