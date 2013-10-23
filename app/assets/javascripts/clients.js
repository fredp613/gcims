

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
  //return false;
})

$(document).on('click', '.btnCorp', function() {
  if ($('#corporation_fields').is(':visible')) {
    $('#corporation_fields').fadeOut(200);
    $('.btnCorp').text("click here to add corporation information");
    $('.btnCorp').attr('class', 'btn btn-small btn-info btnCorp')
  } 
  else {
    $('#corporation_fields').fadeIn(300);
    $('.btnCorp').text("cancel");
    $('.btnCorp').attr('class', 'btn btn-small btn-danger btnCorp')
  }
  return false;
  
});

$(document).on('click', 'submitCorp', function() {
  $('#frmCorp').submit();
  return false;
})

$(document).on('click', '.btnCharity', function() {
  if ($('#charity_fields').is(':visible')) {
    $('#charity_fields').fadeOut(200);
    $('.btnCharity').text("click to add charity information");
    $('.btnCharity').attr('class', 'btn btn-small btn-info btnCharity')
  } 
  else {
    $('#charity_fields').fadeIn(300);
    $('.btnCharity').text("cancel");
    $('.btnCharity').attr('class', 'btn btn-small btn-danger btnCharity')
  }
  return false;
  
});

$(document).on('click', 'submitCharity', function() {
  $('#frmCharity').submit();
  return false;
})








