

var ready2;
ready2 = 

  function() {

  $('.loader').fadeOut(200);
  $('#frmContainer').fadeIn(300);
  //if ($('#client_name')) {
   $('#frmClient').formToWizard({ submitButton: 'clientSubmit' });  
  //}
  

}


$(document).on('page:load', ready2);
$(document).ready(ready2);


$(document).on('click', '#client_incorporated', function() {

  var thisCheck = $(this)
    if (thisCheck.is (':checked')) {
      $('#corporation_fields').fadeIn(100);
    } 
    else {
      $('#corporation_fields').fadeOut(100);
    }
  })

$(document).on('click', '#client_registeredcharity', function() {

  var thisCheck = $(this)
    if (thisCheck.is (':checked')) {
      $('#charity_fields').fadeIn(100);
    } 
    else {
      $('#charity_fields').fadeOut(100);
    }
  })

$(document).on('click', '#client_registeredband', function() {

  var thisCheck = $(this)
    if (thisCheck.is (':checked')) {
      $('#band_fields').fadeIn(100);
    } 
    else {
      $('#band_fields').fadeOut(100);
    }
  })

  $(document).on('click', '#clientSubmit', function() {
    $('#frmClient').submit();
    return false;
  })

  $(document).on('click', '.btnCorp', {action: 'new'}, corp_click );
  $(document).on('click', '.btnEditCorp', {action: 'edit'}, corp_click );

//some issue exists here
  $(document).on('click', '#submitCorp', function() {    
    $('#frmCorp').submit();
    return false;
  })

  $(document).on('click', '.btnCharity', {action: 'new'}, charity_click );
  $(document).on('click', '.btnEditCharity', {action: 'edit'}, charity_click );

  $(document).on('click', '#submitCharity', function() {
    $('#frmCharity').submit();
    return false;
  })

  $(document).on('click', '.btnBand', {action: 'new'}, band_click );
  $(document).on('click', '.btnEditBand', {action: 'edit'}, band_click );


  $(document).on('click', '#submitBand', function() {
    $('#frmBand').submit();
    return false;
  })




function band_click(event) {
  
  var arg = event.data.action
  //alert(arg)
  if ($('#band_fields').is(':visible')) {
    $('#band_fields').fadeOut(100);
     if (arg == 'edit') {
        $('.btnEditBand').text("");
        $('.btnEditBand').attr('class', 'icon-large icon-pencil black btnEditBand')
        $('.btnDelBand').show();
        $('#band_view').show();

      } else {
        $('.btnBand').text("click to add band information");
        $('.btnBand').attr('class', 'btn btn-small btn-info btnBand')
      } 
  } 
  else {

    $('#band_fields').fadeIn(200);
     if (arg == "edit") {
        $('.btnEditBand').text("cancel");
        $('.btnEditBand').attr('class', 'btn btn-small btn-danger btnEditBand');
        $('.btnDelBand').hide();
        $('#band_view').hide();
      } else {
        $(this).text("cancel");
        $(this).attr('class', 'btn btn-small btn-danger btnBand')
      }
  }
  return false;
}



function charity_click(event) {
  var arg = event.data.action
  //alert(arg)
  if ($('#charity_fields').is(':visible')) {
    $('#charity_fields').fadeOut(100);
     if (arg == 'edit') {
        $('.btnEditCharity').text("");
        $('.btnEditCharity').attr('class', 'icon-large icon-pencil black btnEditCharity')
        $('.btnDelCharity').show();
        $('#charity_view').show();

      } else {
        $('.btnCharity').text("click to add charity information");
        $('.btnCharity').attr('class', 'btn btn-small btn-info btnCharity')
      } 
  } 
  else {
    $('#charity_fields').fadeIn(100);
     if (arg == "edit") {
        $('.btnEditCharity').text("cancel");
        $('.btnEditCharity').attr('class', 'btn btn-small btn-danger btnEditCharity');
        $('.btnDelCharity').hide();
        $('#charity_view').hide();
      } else {
        $('.btnCharity').text("cancel");
        $('.btnCharity').attr('class', 'btn btn-small btn-danger btnCharity')
      }
  }
  return false;
  
}

function corp_click(event) {
  var arg = event.data.action
  //alert(arg)
  if ($('#corporation_fields').is(':visible')) {
    $('#corporation_fields').fadeOut(100);
     if (arg == 'edit') {
        $('.btnEditCorp').text("");
        $('.btnEditCorp').attr('class', 'icon-large icon-pencil black btnEditCorp')
        $('.btnDelCorp').show();
        $('#corporation_view').show();

      } else {
        $('.btnCorp').text("click to add corporation information");
        $('.btnCorp').attr('class', 'btn btn-small btn-info btnCorp')
      } 
  } 
  else {
    $('#corporation_fields').fadeIn(100);
     if (arg == "edit") {
        $('.btnEditCorp').text("cancel");
        $('.btnEditCorp').attr('class', 'btn btn-small btn-danger btnEditCorp');
        $('.btnDelCorp').hide();
        $('#corporation_view').hide();
      } else {
        $('.btnCorp').text("cancel");
        $('.btnCorp').attr('class', 'btn btn-small btn-danger btnCorp')
      }
  }
  return false;
  
}









