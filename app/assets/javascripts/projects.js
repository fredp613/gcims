


var createModal = function(link, title) {
  $('.modal-title').html(title);
  $('<div id="modalId" />').appendTo('.modal-body');
  $('#modalId').load(link);
  $("#myModal").modal();	

} 

/**/ 
$('.newProject').on('click', function() {
      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Create Project Wizard');
      return false;    
 });
/**/

 $("#myModal").on('hidden', function() {
    $("#modalId").remove();
 });



