$(document).ready(function() {
  var estadosTable = $('#estados-table').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": $('#estados-table').data('source'),
    "pagingType": "full_numbers",
    columnDefs: [ { orderable: false, targets: [3,4] } ],
    "language": {
      "sUrl": "datatable_i18n"
    },
    "initComplete": function(settings, json) { $('select').material_select(); },
    "drawCallback": function( settings ) { $('.paginate_button').addClass("waves-effect"); },
  });

  $(document).on('ajax:complete', ".estado-form", function(){
    estadosTable.fnUpdate();
  });
  $(document).on('ajax:complete', ".estado-excluir", function(){
    estadosTable.fnUpdate();
  });

});
