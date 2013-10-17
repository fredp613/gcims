

//$('#cover').addClass("cover")
//$('.cover').toggle();

//$(function(){
 // $('.cover').show();
 // $('.cover').fadeOut(200);
 // $('#results').fadeIn(200);  
//});


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

  

  //psls = $('#project_applications_attributes_0_subserviceline').html();
  //console.log(psls)
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



$('.modal-dialog').on('change', '#project_applications_attributes_0_productserviceline',  function() {
  //alert('test');
  var $psl = $('#project_applications_attributes_0_productserviceline').find(':selected').val();
  //var $ssls = $('#project_applications_attributes_0_subserviceline').html();
  

   var params = {'psl':$psl}; 
    $.getJSON('/subservicelines', params, function(data){ 
        
        var ssls = data;
        //var ssls = data.ssl_name
        
        console.log(ssls)
        
        var items = [];


        $.each(data, function(i) {
            items.push('<option value="' + data[i].id + '">' + data[i].ssl_name + '</li>');
        });

        if (ssls) {
          $('#project_applications_attributes_0_subserviceline').html(items.join(''));
        }
        else {
          $('#project_applications_attributes_0_subserviceline').empty();
        }

    });   

});

$('.modal-dialog').on('change', '#project_applications_attributes_0_subserviceline',  function() {
  //alert('test');
  var $ssl = $('#project_applications_attributes_0_subserviceline').find(':selected').val();
  //var $ssls = $('#project_applications_attributes_0_subserviceline').html();
  

   var params = {'ssl':$ssl}; 
    $.getJSON('/summarycommitments', params, function(data){ 
        
        var scs = data;
        //var ssls = data.ssl_name
        
        console.log(scs)
        
        var items = [];


        $.each(data, function(i) {
            items.push('<option value="' + scs[i].id + '">' + scs[i].sc_name + '</li>');
        });

        if (scs) {
          $('#project_applications_attributes_0_summarycommitment').html(items.join(''));
        }
        else {
          $('#project_applications_attributes_0_summarycommitment').empty();
        }

    });   

  /**  if ($('#project_applications_attributes_0_summarycommitment option').length == 1) {
      $('#project_applications_attributes_0_summarycommitment option').attr('selected', true);
    } **/

});

$('.modal-dialog').on('change', '#project_applications_attributes_0_summarycommitment',  function() {
  //alert('test');

  
  var $sc = $('#project_applications_attributes_0_summarycommitment').find(':selected').val();
  //var $ssls = $('#project_applications_attributes_0_subserviceline').html();
  

   var params = {'sc':$sc}; 
    $.getJSON('/commitmentitems', params, function(data){ 
        
        var cis = data;
        //var ssls = data.ssl_name
        
        console.log(cis)
        
        var items = [];


        $.each(data, function(i) {
            items.push('<option value="' + cis[i].id + '">' + cis[i].ci_name + '</li>');
        });

        if (cis) {
          $('#project_applications_attributes_0_commitmentitem').html(items.join(''));
        }
        else {
          $('#project_applications_attributes_0_commitmentitem').empty();
        }

    });   

});








