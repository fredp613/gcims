



var ready15;
ready15 = 

function() {

$("ul.tree ul").hide();


}


$(document).on('page:load', ready15);
$(document).ready(ready15);


var toggleTree = function() {
	
	var $icon = $(this).find(".expandable")

	if ($icon.hasClass("icon-folder-close")) {
    
    $(this).nextAll("ul").show(250);
		$icon.removeClass("icon-folder-close");
		$icon.addClass("icon-folder-open")

	}
	else {
    
    $(this).nextAll("ul").hide(250);
		$icon.removeClass("icon-folder-open");
		$icon.addClass("icon-folder-close");
	}
    return false;
}



$(document).on('click', '.pras_item', toggleTree);


 
 $(document).on('click','.editPsl', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Edit');
      return false;    
 })

  $(document).on('click','.editCi', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Edit');
      return false;    
 })

   $(document).on('click','.editSsl', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Edit');
      return false;    
 })

 $(document).on('click','.editSc', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Edit');
      return false;    
 })

 $(document).on('click','.newPras', function() {
      //e.preventDefault();
      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Create PRAS Branch');
      return false;      

 })

 $(document).on('click','.newCi', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Create Commitment Item');
      return false;    
 })

   $(document).on('click','.newSsl', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Create Sub Service Line');
      return false;    
 })

 $(document).on('click','.newSc', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Create Summary Commitment');
      return false;    
 })

 var createModal = function(link, title) {
  $('.modal-title').html(title);
  $('<div id="modalId" />').appendTo('.modal-body').load(link);
  $('#myModal').modal();

} 


 $(document).on('hidden','#myModal', function() {
    $('#modalId').remove();

 })

 

