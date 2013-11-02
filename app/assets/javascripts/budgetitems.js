

$(document).on('blur', '#budgetitem_forecast', {element: 'budgetitem_forecast'}, convertCurrency );
$(document).on('blur', '#budgetitem_actual', {element: 'budgetitem_actual'}, convertCurrency );


function convertCurrency(event) {
		//convert number to currency
		var element = event.data.element
		$('#' + element).formatCurrency({ symbol:''});
}