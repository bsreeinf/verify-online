

$(document).on('page:change', function(event) {
  $('#college').on('change', function() {
    var id, selectedCollege;
    selectedCollege = $('#college')[0];
    id = selectedCollege.value;
    if(id != ''){
      $('#verification_amount_loader').fadeIn(50);
      $.ajax({
        type: 'GET',
        url: 'colleges/' + id + '.json',
        cache: false,
      }).done( function(response) {
        $('#verification_amount_lable').text("" + response.verification_amount);
      }).always( function(response) {
        $('#verification_amount_loader').fadeOut(50);
      });
    } else {
      $('#verification_amount_lable').text('0');
    }
  });

  $("#college > option").each(function(i) {
    $("#college").val($("#college_id").data("url"));
  });
  $("#college").trigger('change');

});
