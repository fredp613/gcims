var ready10

ready10 = 
function () {

  //$(document).on('click', '.newProject', function(e){
$('#financial').on('click', '.btnAddBudgetItem', function() { 
      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, $(this).data('dialog-title'));
      return false;
}); 
 $('#financial').on('click','.btnEditBudgetItem', function() { 
      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, $(this).data('dialog-title'));
      return false;
});
$('#financial').on('click', '.btnAddBudgetItem_other', function() { 
      var link = $(this).attr('href') + '&layout="false"';
      createModal(link, $(this).data('dialog-title'));
      return false;
}); 

var createModal = function(link, title) {
      $('.modal-title').html(title);
      $('<div id="modalId" />').appendTo('.modal-body');
      $('#modalId').load(link);
      $("#myModal").modal();  
      //psls = $('#project_applications_attributes_0_subserviceline').html();
      //console.log(psls)
  } 

$('#myModal').on('hidden', function() {
  $("#modalId").remove();
});


}


$(document).ready(ready10);
$(document).on('page:load', ready10);

 