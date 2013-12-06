/* Created by jankoatwarpspeed.com - modified by Frederick Pearson */


    $.fn.formToWizard = function(options) {
        options = $.extend({ 
            submitButton: $(".submit").find(":submit").attr("id")
        }, options); 
        
        var element = this;
        
        var steps = $(element).find("fieldset");
        var count = steps.size();

        var submitButtonName = "#" + options.submitButton;
        $(submitButtonName).hide();
       
        // 2 
        if ($('.modal-header').length != 0) {
          $stepsHtml = $("<br><ul id='steps' class='nav nav-pills' style='margin-bottom:-10px;'></ul>")
          $('#paging').empty();
          $('#paging').append($stepsHtml);
        } else {
          $(element).before("<ul id='steps' class='nav nav-pills'></ul>");
        }

        steps.each(function(i) {
            $(this).wrap("<div id='step" + i + "' class='tab-pane step'></div>");
            $(this).append("<p id='step" + i + "commands' class='span10' style='padding-top:10px;margin-left:0px;'></p>");

            // 2
            var name = 'step' + (i+1) //$(this).find("legend").html(); 
            $("#steps").append("<li id='stepDesc" + i + "'>" + "<a id='stepLink" + i + "' data-toggle='tab' href='#step" + i + "'>" + name + "</a></li>");

            if (i == 0) {
                createNextButton(i);
                selectStep(i);
                //selectStep(i)
             //   $(submitButtonName).hide();                
            }
            else if (i == count - 1) {
                
                createPrevButton(i);
                
                //alert(submitButtonName) 
               // $(submitButtonName).show();
                
            }
            else {
                
                createPrevButton(i);
                createNextButton(i);
                
             //   $(submitButtonName).hide();
                
            }


           
           /** else {
             selectStep(i);
            }**/
        });

      


        var errors = $(element).find(".help-inline").first();                    
            if (errors.length > 0) { 
             selectErrorStep();
        }

        //ADD THE BIND CLICK ELEMENTS TO A TAGS IN LI

        function createPrevButton(i) {
            var stepName = "step" + i;
            $("#" + stepName + "commands").append("<button id='" + 
                stepName + "Prev' class='btn btn-small btn-info', style='margin-right:10px;'>Back</button>");

            $("#" + stepName + "Prev").bind("click", function() {
                //$("#" + stepName).hide();
                $("#step" + i).removeClass('active')
                
               // $("#step" + (i - 1)).fadeIn(280);
               // $(submitButtonName).hide();
                selectStep(i - 1);
                return false;
            });

            $("#stepLink" + i).bind("click", function() {
                //$("#" + stepName).hide();
              //  $("#step" + i).removeClass('active')
                
               // $("#step" + (i - 1)).fadeIn(280);
               
               // selectStep(i - 1);
                if (i == (count - 1)) {
                   $(submitButtonName).show();
                } else {
                   $(submitButtonName).hide();
                }

                //return false;
            });
        }

        function createNextButton(i) {
            var stepName = "step" + i;
            $("#" + stepName + "commands").append("<button id='" + stepName + "Next' class='btn btn-small btn-info'>Next</button>");

            $("#" + stepName + "Next").bind("click", function(e) {
              //  $("#" + stepName).hide();
                $("#step" + i).removeClass('active')
                
               // $("#step" + (i + 1)).fadeIn(300);
                
                selectStep(i + 1);
                return false;
            });

            $("#stepLink" + i).bind("click", function() {
              //  $("#" + stepName).hide();
              //  $("#step" + i).removeClass('active')
                
               // $("#step" + (i + 1)).fadeIn(300);
                //selectStep(i + 1);
              if (i == (count - 1)) {
                   $(submitButtonName).show();
                } else {
                   $(submitButtonName).hide();
                }
                //return false;
            });
        }

        function selectStep(i) {
            $("#steps li").removeClass("active");
            $("#stepDesc" + i).addClass("active");
            $("#step" + i).addClass("active")

             if (i == (count - 1)) {
                   $(submitButtonName).show();
                } else {
                   $(submitButtonName).hide();
                }
           
        }

        function selectErrorStep() {
                      
            var errors = $(element).find(".help-inline").first(); 
            var parent = errors.closest('div .step').attr("id").substring(5,4)            
            //var test = errors.closest('div .step').attr("id")
            //alert(test);
            $("#steps li").removeClass("active"); 
            $("#stepDesc" + parent).addClass("active");                                                           
            $(".step").removeClass('active');                            
            $("#step" + parent).addClass('active');    

            if (parent == (count - 1)) {
             $(submitButtonName).show();                     
            }
        }


    }
