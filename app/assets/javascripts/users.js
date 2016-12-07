$(document).on('turbolinks:load', function(){
  var usersTable = $('#users-table').dataTable({
    processing: true,
    serverSide: true,
    ajax: $('#users-table').data('source'),
    pagingType: "full_numbers",
    autoWidth: false,
    columnDefs: [ { orderable: false, targets: [2,3,4] } ],
    language: {
      sUrl: "datatable_i18n"
    },
    drawCallback: function( settings ) {
      $('.paginate_button').addClass("waves-effect");
      $('select').material_select();
      $('.tooltipped').tooltip({delay: 1000});
    },
  });

  $(document).on('ajax:complete', ".user-form", function(){
    usersTable.fnStandingRedraw();
  });
  $(document).on('ajax:complete', ".excluir-user", function(){
    usersTable.fnStandingRedraw();
  });

});
