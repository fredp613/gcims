var createModal = function(link, title) {
  $('.modal-title').html(title);
  $('<div id="modalId" />').appendTo('.modal-body').load(link);
  $('#myModal').modal();

} 
 
 $('.editSc').on('click', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Edit');
      return false;    
 });

 $('.newSc').on('click', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'New summarycommitment');
      return false;    
 });


 $('#myModal').on('hidden', function() {
    $('#modalId').remove();

 });
