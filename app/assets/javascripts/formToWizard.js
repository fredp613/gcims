/* Created by jankoatwarpspeed.com */

    $.fn.formToWizard = function(options) {
        options = $.extend({ 
            submitButton: $(".submit").find(":submit").attr("id")
        }, options); 
        
        var element = this;

        var steps = $(element).find("fieldset");
        var count = steps.size();

       
        

        var submmitButtonName = "#" + options.submitButton;
        $(submmitButtonName).hide();

        // 2 
        $(element).before("<ul id='steps' class='nav nav-pills'></ul>");

        steps.each(function(i) {
            $(this).wrap("<div id='step" + i + "'></div>");
            $(this).append("<p id='step" + i + "commands'></p>");

            // 2
            var name = 'step' + (i+1) //$(this).find("legend").html(); 
            $("#steps").append("<li id='stepDesc" + i + "'>" + "<a href='#'><span>" + name + "</span></a></li>");

            if (i == 0) {
                createNextButton(i);
                selectStep(i);
            }
            else if (i == count - 1) {
                $("#step" + i).hide();
                createPrevButton(i);
            }
            else {
                $("#step" + i).hide();
                createPrevButton(i);
                createNextButton(i);
            }
        });

        function createPrevButton(i) {
            var stepName = "step" + i;
            $("#" + stepName + "commands").append("<button id='" + stepName + "Prev' class='btn btn-small btn-info'>Back</button>");

            $("#" + stepName + "Prev").bind("click", function(e) {
                $("#" + stepName).hide();
                $("#step" + (i - 1)).show();
                $(submmitButtonName).hide();
                selectStep(i - 1);
                return false;
            });
        }

        function createNextButton(i) {
            var stepName = "step" + i;
            $("#" + stepName + "commands").append("<button id='" + stepName + "Next' class='btn btn-small btn-info'>Next</button>");

            $("#" + stepName + "Next").bind("click", function(e) {
                $("#" + stepName).hide();
                $("#step" + (i + 1)).show();
                if (i + 2 == count)
                    $(submmitButtonName).show();
                selectStep(i + 1);
                return false;
            });
        }

        function selectStep(i) {

            $("#steps li").removeClass("active current");
            $("#stepDesc" + i).addClass("active current");

            var errors = $(element).find(".help-inline").first();

            if (errors > 0) {
                var parent = errors.closest("div[id]").attr("id").substring(5,4);
                    
                if (i != parent) {
                  $("#stepDesc" + i).removeClass("active current");
                  $("#stepDesc" + parent).addClass("active current");
                }
         }

        }

    }
