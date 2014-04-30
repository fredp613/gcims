// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery-ui
//= require jquery_ujs
//= require jquery.formatCurrency-1.4.0
//= require twitter/bootstrap
//= require bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require_tree .

var ready1;
ready1 = function() {
  

  $(window).bind("popstate", function(){
    $.getScript(location.href);
  });
  

  $(window).load(function() {
    $(".loader").fadeOut("slow");
  });

  bind_datepicker();
  bind_datepicker_year();

  
 

}

$(document).on('page:load', ready1);
$(document).ready(ready1);


function bind_datepicker() {
  $element = $(document).find('.datepicker')

  $element.datepicker({
    autoclose: 'true',
   format: 'yyyy-mm-dd'
  });
}

function bind_datepicker_year() {
  $element = $(document).find('.datepicker_year')

  $element.datepicker({
    autoclose: 'true',
    format: 'yyyy',
    viewMode: 'years',
    minViewMode: 'years'
  });
}





