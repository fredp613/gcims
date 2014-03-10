var ready10

ready10 = 
function () {

    //$(document).on('click', '.newProject', function(e){
  $('#financial').on('click', '.btnAddBudgetItem', showModal ); 
   $('#financial').on('click','.btnEditBudgetItem', showModal );
  $('#financial').on('click', '.btnAddBudgetItem_other', showModal ); 

  function showModal() { 
      var link = ''
      var header_link = ''
      var klass = $(this).attr('class')

      if (klass == 'btnAddBudgetItem_other btn btn-info btn-small') {
        link = $(this).attr('href') + '&layout="false"';
        header_link = $(this).attr('href') + '&layout="false&header=true"';
      } else {
        link = $(this).attr('href') + '?layout="false"';
        header_link = $(this).attr('href') + '?layout="false&header=true"';
      }
      
      createModal(link, header_link, $(this).data('dialog-title'));
      return false;
  }

  var createModal = function(link, header_link, title) {
        $('.modal-title').html(title);
        $('<div id="dynamic_header_content" />').appendTo('.modal-header');
        $('<div id="modalId" />').appendTo('.modal-body');
        $('#dynamic_header_content').load(header_link);
        $('#modalId').load(link);
        $("#myModal").modal();  
        //psls = $('#project_applications_attributes_0_subserviceline').html();
        //console.log(psls)
    } 

  $('#myModal').on('hidden', function() {
    $("#modalId").remove();
    $('#dynamic_header_content').remove();
  });

  $(window).bind('popstate', function() {
    $.getScript(location.href);
  }) 


}


$(document).ready(ready10);
$(document).on('page:load', ready10);



$(document).on('keyup', '.search_project',submitSearchForm)
$(document).on('click', '.search_project_submit',submitSearchForm)
$(document).on('change', '#projects_page_size',submitSearchForm)
$(document).on('click', '.reset_project_submit',resetSearchForm)

function submitSearchForm(){
  
  var form = $('#project_search_form')
  var action = form.attr('action');
  var formData = form.serialize();
  // if ($('.search_project').val("")) {
  //   $('#projects_page_size').val(5);
  // }
  $.get(action, formData, null, 'script');

  history.pushState(null, document.title, action + "?" + formData);
  
  
}

function resetSearchForm(){
 
  $('#projects_page_size').val(10);
  $('.search_project').val("");
  $('#project_search_form').submit();
  
}

 $('#table_container').on('click', '.pagination a', function() {
    $.getScript(this.href);
    history.pushState(null,"",this.href)
    return false;
  })

$(window).bind("popstate", function(){
    $.getScript(location.href);
  });


 