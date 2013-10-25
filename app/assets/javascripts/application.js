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
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap
//= require bootstrap-datepicker
//= require turbolinks
//= require_tree .




idleTime = 0;
$(function () {
  //Increment the idle time counter every minute.
  var idleInterval = setInterval(timerIncrement, 60000); // 1 minute

  //Zero the idle timer on mouse movement.
  $(this).mousemove(function (e) {
      idleTime = 0;
      
  });
  $(this).keypress(function (e) {
      idleTime = 0;
      
  });

  $(window).bind("popstate", function(){
  	$.getScript(location.href);
  });


  $element = $(document).find('.datepicker')

  $element.datepicker({
    autoclose: 'true',
    format: 'yyyy-mm-dd'
  });

  $(window).load(function() {
    $(".loader").fadeOut("slow");
  });

});

function timerIncrement() {
  idleTime = idleTime + 1;
  if (idleTime > 31) { // 31 minutes
      window.location.reload();
  }
}



//$('#tabs').tab();

/**idleTime = 0;
//Increment the idle time counter every minute.
var idleInterval = setInterval("timerIncrement()", 60000); // 1 minute

//Zero the idle timer on mouse movement.
$(this).mousemove(function (e) {
    idleTime = 0;
});
$(this).keypress(function (e) {
    idleTime = 0;
});

function timerIncrement() {
    idleTime = idleTime + 1;
    if (idleTime > 29) { // 30 minutes
        location.reload();
    }	
}
**/


