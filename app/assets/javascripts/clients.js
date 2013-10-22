

$(function() {

  $('.loader').fadeOut(200);
  $('#frmContainer').fadeIn(300);
  $('#frmClient').formToWizard({ submitButton: 'clientSubmit' });

});

$('#frmContainer').on('click', '#client_incorporated', function() {

var thisCheck = $(this)
  if (thisCheck.is (':checked')) {
    $('#corporation_fields').fadeIn(300);
  } 
  else {
    $('#corporation_fields').fadeOut(300);
  }
})

$('#frmContainer').on('click', '#client_registeredcharity', function() {

var thisCheck = $(this)
  if (thisCheck.is (':checked')) {
    $('#charity_fields').fadeIn(300);
  } 
  else {
    $('#charity_fields').fadeOut(300);
  }
})

$('#frmContainer').on('click', '#client_registeredband', function() {

var thisCheck = $(this)
  if (thisCheck.is (':checked')) {
    $('#band_fields').fadeIn(300);
  } 
  else {
    $('#band_fields').fadeOut(300);
  }
})

$('#frmContainer').on('click', '#clientSubmit', function() {
  $('#frmClient').submit();
  return false;
})






