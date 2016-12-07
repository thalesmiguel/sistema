$(document).on('turbolinks:load', function(){
  var cidadesTable = $('#cidades-table').dataTable({
    processing: true,
    serverSide: true,
    ajax: $('#cidades-table').data('source'),
    pagingType: "full_numbers",
    autoWidth: false,
    columnDefs: [ { orderable: false, targets: [2,3,4,5] } ],
    language: {
      sUrl: "datatable_i18n"
    },
    drawCallback: function( settings ) {
      $('.paginate_button').addClass("waves-effect");
      $('select').material_select();
      $('.tooltipped').tooltip({delay: 1000});
    },
  });

  $(document).on('ajax:complete', ".cidade-form", function(){
    cidadesTable.fnStandingRedraw();
  });
  $(document).on('ajax:complete', ".excluir-cidade", function(){
    cidadesTable.fnStandingRedraw();
  });

});
