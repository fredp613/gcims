
var ready3 
ready3 = 
function () {

  $('.loader').fadeOut(200);

  $('#results').fadeIn(300);

  $('#table_container').on('click', '.pagination a', function() {
    $.getScript(this.href);
    history.pushState(null,"",this.href)
    return false;
  })


  $("#myModal").on('hidden', function() {
    $("#modalId").remove();
  });


  $(".newProject").attr('disabled', false);

  $(".size").on('change', function() {
    $(this).parent('form').submit();



   
  });
  

}

$(document).ready(ready3);
$(document).on('page:load', ready3);

$(document).on('click', '#newCT', function() {
    var link = $(this).attr('href') + '?layout=false'
    createModal(link, 'Create Client Wizard');
    return false;
  })




  //$(document).on('click', '.newProject', function(e){
  $(document).on('click', '.newProject', function() { 
     // $.getScript(this.href);
        //e.preventDefault();  
        var link = $(this).attr('href') + '?layout="false"';
        createModal(link, 'Create Project Wizard');         


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







// $(document).on('click', '#reset', function() {
//   $('#search_field').val("")
// })


//$(document).on('blur', '#project_applications_attributes_0_requested', {element: 'project_applications_attributes_0_requested'}, convertCurrency );











