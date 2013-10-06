



$(function(){
  $('.cover').fadeOut(200);
  $('#results').fadeIn(200);
    
});


$(".newProject").attr('disabled', false);

$(".size").on('change', function() {
  $(this).parent('form').submit();

  /**$(this).parent('form').submit(function() {
    $.ajax({
          url: this.action,
          type: this.method,
          data: $(this).serialize(),
          dataType: 'json',
          success: function(data){
            $('#client_records').html(data);
            //location.reload(true)
          },
          error: function(xhr){
              var errors = $.parseJSON(xhr.responseText)
             
              $('#myModal').modal('toggle');
          }
        });
    return false;
  }); **/
});




var createModal = function(link, title) {
  $('.modal-title').html(title);
  $('<div id="modalId" />').appendTo('.modal-body');
  $('#modalId').load(link);
  $("#myModal").modal();  

} 


//$(document).on('click', '.newProject', function(e){
$("#table_container").on('click', '.newProject', function() { 
   // $.getScript(this.href);
      //e.preventDefault();  
      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Create Project Wizard');
      return false;
  }); 

 $("#myModal").on('hidden', function() {
    $("#modalId").remove();
 });



