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
    var $ci = $('#project_applications_attributes_0_commitmentitem_id').find(':selected').val();
    filter_sc('ci', $ci);
    filter_ssl('ci', $ci);
    filter_psl('ci', $ci);
    


  }); 
 

}



$(document).ready(ready10);
$(document).on('page:load', ready10);

$(document).on('keyup', '.search_project',submitSearchForm)
$(document).on('click', '.search_project_submit',submitSearchForm)

$(document).on('change', '#projects_page_size', submitSearchForm)

$(document).on('click', '.reset_project_submit',resetSearchForm)
$(document).on('blur', '#project_applications_attributes_0_commitmentitem_id', activateDateFields)
$(document).on('blur', '#project_applications_attributes_0_productserviceline', activateDateFields)
 $(document).on('change','#project_applications_attributes_0_commitmentitem_id', activateDateFields)

function activateDateFields() {
  var id = $("#project_applications_attributes_0_commitmentitem_id").val();
  var param = {'id': id};

  $.getJSON('/commitmentitems', param, function(data){ 
                      
       var startdate 
       var enddate

       $.each(data, function(i) {                 
           startdate = data[i].startdate
           enddate = data[i].enddate        
       });       

       var sd1 = $.format.date(startdate, "yyyy-MM-dd")
       var ed1 = $.format.date(enddate, "yyyy-MM-dd")               
             

      if (sd1 == null) {
        sd1 = "2000-01-01";
        ed1 = "2500-01-01";
      } 
      $(".datepicker").datepicker("destroy");               
      $(".datepicker").datepicker("setStartDate", new Date(sd1));
      $(".datepicker").datepicker("setEndDate", new Date(ed1));
      $(".datepicker").datepicker("setFormat", "yyyy-mm-dd");
      $(".datepicker").datepicker("autoclose", 'true');

      


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
    alert('An error occurred contact your system administrator');
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
    alert('An error occurred contact your system administrator')
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
    alert('Error - contact system administrator')
   }



    $.getJSON('/pras/pras_index', params, function(data){ 
        
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


function getCommitmentItemData() {

  // $("#project_applications_attributes_0_startdate").datepicker("remove");

  var $ci1 = $('#project_applications_attributes_0_commitmentitem_id').find(':selected').val();
  var $ci = $('#project_applications_attributes_0_commitmentitem_id').val();

  if ($ci != null) {

     var params = {'id': $ci};
     
    $.getJSON('/commitmentitems', params, function(data){ 
                          
         var startdate 
         var enddate

         $.each(data, function(i) {                 
            startdate = data[i].startdate
            enddate = data[i].enddate        
         });       

         var sd1 = $.format.date(startdate, "yyyy-MM-dd")
         var ed1 = $.format.date(enddate, "yyyy-MM-dd")
          
          $(document).delegate(".datepicker", "focusin", function(){             
            
            if (sd1 == null) {
              sd1 = "2000-01-01";
              ed1 = "2500-01-01";
            } 
            $(".datepicker").datepicker("destroy");               
            $(".datepicker").datepicker("setStartDate", new Date(sd1));
            $(".datepicker").datepicker("setEndDate", new Date(ed1));
            $(".datepicker").datepicker("setFormat", "yyyy-mm-dd"); 
   
          });


      }); 


  }


}

function getCommitmentItemDataOnChange() {

  var $ci1 = $('#project_applications_attributes_0_commitmentitem_id').find(':selected').val();
  var $ci = $('#project_applications_attributes_0_commitmentitem_id').value;

  if ($ci != null) {

     var params = {'id': $ci};
     
    $.getJSON('/commitmentitems', params, function(data){ 
                      
         var startdate 
         var enddate

         $.each(data, function(i) {                 
             startdate = data[i].startdate
             enddate = data[i].enddate        
         });       

       var sd1 = $.format.date(startdate, "yyyy-MM-dd")
       var ed1 = $.format.date(enddate, "yyyy-MM-dd")               
                   
        if (sd1 == null) {
          sd1 = "2000-01-01";
          ed1 = "2500-01-01";
        } 
        $(".datepicker").datepicker("destroy");               
        $(".datepicker").datepicker("setStartDate", new Date(sd1));
        $(".datepicker").datepicker("setEndDate", new Date(ed1));
        $(".datepicker").datepicker("setFormat", "yyyy-mm-dd");

      });    
  }
}


function submitSearchForm(val){
  
  var form = $('#project_search_form')
  var action = form.attr('action');
  var formData = form.serialize();

  // $.get(action, formData , null, 'script');
  form.submit();
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


 