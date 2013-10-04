

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