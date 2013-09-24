

$("ul.tree ul").hide();


var handleClick = function() {
	$(this).nextAll("ul").toggle(200);

	var $parentLI = $(this).parent("li")

	if ($parentLI.hasClass("icon-folder-open")) {
		$parentLI.removeClass("icon-folder-open");
		$parentLI.addClass("icon-folder-close")

	}
	else {
		$parentLI.removeClass("icon-folder-closed");
		$parentLI.addClass("icon-folder-open");
	}
    return false;
}

$('.pras_item').on('click', handleClick);


 
 $('.editPsl').on('click', function() {

      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Edit');
      return false;    
 });

 $('.newPras').on('click', function() {
      //e.preventDefault();
      var link = $(this).attr('href') + '?layout="false"';
      createModal(link, 'Create PRAS Branch');
      return false;      

 });

 var createModal = function(link, title) {
  $('.modal-title').html(title);
  $('<div id="modalId" />').appendTo('.modal-body').load(link);
  $('#myModal').modal();

} 


 $('#myModal').on('hidden', function() {
    $('#modalId').remove();

 });

 

