


var createModal = function(link, title) {
  $('.modal-title').html(title);
  $('<div id="modalId" />').appendTo('.modal-body');
  $('#modalId').load(link);
  $("#myModal").modal();	

} 


//$(document).on('click', '.newProject', function(e){
$(".newProject").on('click', function() { 
   // $.getScript(this.href);
      //e.preventDefault();  
      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Create Project Wizard');
      return false;
  }); 

 $("#myModal").on('hidden', function() {
    $("#modalId").remove();
 });



