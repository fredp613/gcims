
var ready 
ready = function () {

    $('.loader').fadeOut(200);
    
    $('#results').fadeIn(300);


    $('#table_container').on('click', '.pagination a', function() {
      $.getScript(this.href);
      history.pushState(null,"",this.href)
      return false;
    })

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
    var $psl = $('#project_applications_attributes_0_productserviceline').find(':selected').val();
    filter_ssl('psl', $psl); 
    filter_sc('psl', $psl);
    filter_ci('psl', $psl);

  });

  $('.modal-dialog').on('change', '#project_applications_attributes_0_subserviceline',  function() {
   // alert('test')
      var $ssl = $('#project_applications_attributes_0_subserviceline').find(':selected').val();
      filter_sc('ssl', $ssl);
      filter_ci('ssl', $ssl);
      filter_psl('ssl', $ssl);

     /** if ($('#project_applications_attributes_0_summarycommitment option').length == 1) {
        $('#project_applications_attributes_0_summarycommitment option').attr('selected', true);
        var $sc = $('#project_applications_attributes_0_summarycommitment').find(':selected').val();
        filter_ci('sc', $sc);  
      } **/

  });

  $('.modal-dialog').on('change', '#project_applications_attributes_0_summarycommitment',  function() {
    //alert('test');
    var $sc = $('#project_applications_attributes_0_summarycommitment').find(':selected').val();
    filter_ci('sc', $sc);
    filter_ssl('sc', $sc);
    filter_psl('sc', $sc);

  });

  $('.modal-dialog').on('change', '#project_applications_attributes_0_commitmentitem_id',  function() {
    //alert('test');
    var $ci = $('#project_applications_attributes_0_commitmentitem').find(':selected').val();
    filter_sc('ci', $ci);
    filter_ssl('ci', $ci);
    filter_psl('ci', $ci);

  });

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
  

}

function filter_ci(paramName, param) {


    if (paramName == 'psl') {
    var params = {'psl': param}; 
   }
   else if (paramName == 'ssl') {
    var params = {'ssl': param};
   }
   else if (paramName == 'sc') {
    var params = {'sc': param};
   }
   else if (paramName == 'ci') {
    var params = {'ci': param};
   }
   else {
    alert('test')
   }

        $.getJSON('/commitmentitems', params, function(data){ 
            
            var cis = data;
            //var ssls = data.ssl_name
            
            console.log(cis)
            
            var items = [];
            if (cis.length !=1 ) {
              items.push('<option value=""></option>')
            }

            $.each(data, function(i) {
                items.push('<option value="' + cis[i].id + '">' + cis[i].ci_name + '</option>');
            });

            if (cis) {
              $('#project_applications_attributes_0_commitmentitem_id').html(items.join(''));
            }
            else {
              $('#project_applications_attributes_0_commitmentitem_id').empty();
            }

        });

}

function filter_sc(paramName, param) {
  
   if (paramName == 'psl') {
    var params = {'psl': param}; 
   }
   else if (paramName == 'ssl') {
    var params = {'ssl': param};
   }
   else if (paramName == 'sc') {
    var params = {'sc': param};
   }
   else if (paramName == 'ci') {
    var params = {'ci': param};
   }
   else {
    alert('test')
   }

    $.getJSON('/summarycommitments', params, function(data){ 
        
        var scs = data;
        //var ssls = data.ssl_name
        
        console.log(scs)
        
        var items = [];
        if (scs.length !=1 ) {
              items.push('<option value=""></option>')
        }

        $.each(data, function(i) {
            items.push('<option value="' + scs[i].id + '">' + scs[i].sc_name + '</option>');
        });

        if (scs) {
          $('#project_applications_attributes_0_summarycommitment').html(items.join(''));
        }
        else {
          $('#project_applications_attributes_0_summarycommitment').empty();
        }

    });   


}

function filter_ssl(paramName, param) {
  
   if (paramName == 'psl') {
    var params = {'psl': param}; 
   }
   else if (paramName == 'ssl') {
    var params = {'ssl': param};
   }
   else if (paramName == 'sc') {
    var params = {'sc': param};
   }
   else if (paramName == 'ci') {
    var params = {'ci': param};
   }
   else {
    alert('test')
   }



    $.getJSON('/subservicelines', params, function(data){ 
        
        var ssls = data;
        //var ssls = data.ssl_name
        
        console.log(ssls)
        
        var items = [];
        if (ssls.length !=1 ) {
              items.push('<option value=""></option>')
        }

        $.each(data, function(i) {
            items.push('<option value="' + ssls[i].id + '">' + ssls[i].ssl_name + '</option>');
        });

        if (ssls) {
          $('#project_applications_attributes_0_subserviceline').html(items.join(''));
        }
        else {
          $('#project_applications_attributes_0_subserviceline').empty();
        }

    });  

}

function filter_psl(paramName, param) {
  
   if (paramName == 'psl') {
    var params = {'psl': param}; 
   }
   else if (paramName == 'ssl') {
    var params = {'ssl': param};
   }
   else if (paramName == 'sc') {
    var params = {'sc': param};
   }
   else if (paramName == 'ci') {
    var params = {'ci': param};
   }
   else {
    alert('test')
   }



    $.getJSON('/productservicelines/pras_index', params, function(data){ 
        
        var psl = data;
        //var ssls = data.ssl_name
        
        console.log(psl)
        
        var items = [];
        $.each(data, function(i) {
            items.push('<option value="' + psl[i].id + '">' + psl[i].psl_name + '</option>');
        });

        if (psl) {
          $('#project_applications_attributes_0_productserviceline').html(items.join(''));
        }
        else {
          $('#project_applications_attributes_0_productserviceline').empty();
        }

    });  

}

$(document).ready(ready);
$(document).on('page:load', ready);








