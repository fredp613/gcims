var createModal = function(link, title) {
  $('.modal-title').html(title);
  $('<div id="modalId" />').appendTo('.modal-body').load(link);
  $('#myModal').modal();

} 
 
 $('.editCi').on('click', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Edit');
      return false;    
 });

 $('.newCi').on('click', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'New commitmentitem');
      return false;      
 });


 $('#myModal').on('hidden', function() {
    $('#modalId').remove();

 });
