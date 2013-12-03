

$(document).on('blur', '#budgetitem_forecast', {element: 'budgetitem_forecast'}, convertCurrency );
$(document).on('blur', '#budgetitem_actual', {element: 'budgetitem_actual'}, convertCurrency );

/**
function convertCurrency(event) {
		//convert number to currency
		var element = event.data.element
		$('#' + element).formatCurrency({ symbol:''});
}**/


$(document).on('keyup', '#budgetitem_forecast',  refreshBalance );
$(document).on('focus', '#budgetitem_forecast',  modifyNumber );
$(document).on('click', 'input[type=checkbox]',  refreshBalance);
$(document).on('click', '#submit_budgetitem', submitForm);

function submitForm() {
	$('#frmBudgetItem').submit();
	return false
}



function refreshBalance() {

	var checkedCount = []
	$('input[type=checkbox]').each(function () {
	   	//checkedCount = []
	    if (this.checked) {
	      checkedCount.push('1')
	    }	    
	    
	});

	var bal = $('#remaining_balance').val();

	if ($('#original_forecast').val() != null ) {
		increment = $('#budgetitem_forecast').val() - $('#original_forecast').val()
	} else {
		increment = $('#budgetitem_forecast').val() 
	}
	

	var new_bal  = bal -  (increment*checkedCount.length) 
	

	if (new_bal < 0) {
		$('#balance_number').show();
		$('#budgetitem_forecast').toNumber();		
		$('.balance').removeClass('alert-success')
		$('.balance').removeClass('alert-warning')		
		$('.balance').addClass('alert-error')		
		$('#txtBalanceIndicator').text("Current balance:")
		$('.icon-ok').hide()
		
	} 
	else if (new_bal == 0) {
		$('#balance_number').hide();	
		$('#budgetitem_forecast').toNumber();		
		$('.balance').removeClass('alert-error')
		$('.balance').removeClass('alert-warning')	
		$('.balance').addClass('alert-success')	
		$('#txtBalanceIndicator').text("Budget balanced")
		// fix the code below	
		//if (!($('.ok')) {
			
		$('.icon-ok').show()
		//}

	}
	else {
		$('#balance_number').show();
		$('#budgetitem_forecast').toNumber();		
		$('.balance').removeClass('alert-error')
		$('.balance').removeClass('alert-success')		
		$('.balance').addClass('alert-warning')	
		$('#txtBalanceIndicator').text("Current balance:")
		$('.icon-ok').hide()
		
	}


		$('#balance_number').text(new_bal)
		$('#balance_number').formatCurrency({ symbol:'$'});
	

	/**if ($('#budgetitem_forecast').val() == '') {
		
		$('input[type=checkbox]').attr('checked', false)

	}**/		

}

function modifyNumber() {
	$('#budgetitem_forecast').toNumber({parseType: 'int'});		
	
}




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