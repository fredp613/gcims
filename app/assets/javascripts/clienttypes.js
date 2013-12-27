$(document).on('click', '#clientCT', function() {
  var param = $('#clienttype_name').val();
  var link = $(this).attr('href') + '?'+ param + '&layout=false' 
//instead just do a GET request and replace the modal contenst
  return false;
	
})