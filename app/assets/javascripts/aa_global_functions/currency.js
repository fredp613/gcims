
function convertCurrency(event) {
    //convert number to currency
    var element = event.data.element
    $('#' + element).formatCurrency({ symbol:''});
}