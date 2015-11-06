

$(document).on('page:change', function(event) {
  var MAX_FILE_SIZE = 512; //kB
  var table_data = [];
  var verification_amount = 0;
  var verification_amount_total = 0;

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
        verification_amount = response.verification_amount;
        $('#verification_amount_lable').text(verification_amount + "");

      }).always( function(response) {
        $('#verification_amount_loader').fadeOut(50);
      });
    } else {
      verification_amount = 0;
      $('#verification_amount_lable').text(verification_amount + "");
    }
  });

  $("#college > option").each(function(i) {
    $("#college").val($("#college_id").data("url"));
  });
  $("#college").trigger('change');

  $('#verify_document').change( function(event) {
    var tmppath = URL.createObjectURL(event.target.files[0]);
    console.log(tmppath);
  });

  $('#form').on('submit', function(event){
    event.preventDefault();
    if(!$.fn.fileValidate($('#verify_document')[0].files[0])){

      return;
    }
    var current_verification_stub = [];

    var id, selectedCollege;
    selectedCollege = $('#college')[0];
    current_verification_stub['college_id'] = selectedCollege.value;
    current_verification_stub['college_name'] = $("#college option")[$("#college")[0].selectedIndex].text
    current_verification_stub['verification_amount'] = verification_amount;
    current_verification_stub['name'] = $('#name').val();
    current_verification_stub['hallticket_no'] = $('#hallticket_no').val();
    current_verification_stub['file_link'] = URL.createObjectURL(($('#verify_document')[0]).files[0]);

    table_data[table_data.length] = current_verification_stub;
    verification_amount_total += verification_amount;
    $('#verification_amount_total_lable').text(Math.round(verification_amount_total * 1.05) + "");

    console.log(table_data);

    // reset fields
    verification_amount = 0;
    $('#verification_amount_lable').text(verification_amount + "");
    $("#form").trigger('reset');

    // add row to table
    $('#verifications_tbody').append('<tr>'+
      '<td>' + current_verification_stub['college_name'] + '</td>' + 
      '<td>' + current_verification_stub['name'] + '</td>' + 
      '<td>' + current_verification_stub['hallticket_no'] + '</td>' + 
      '<td><a href="' + current_verification_stub['file_link'] + '" target="blank"><i class="fa fa-download dark"></i></a></td>' + 
      '<td>Rs ' + current_verification_stub['verification_amount'] + '</td>' + 
      '</tr>');
  });
  
  $.fn.fileValidate = function(file, MAX_FILE_SIZE){
    if(file === undefined)
      return false;
    if(file.size > MAX_FILE_SIZE * 1024)
      return false;
    return true;
  }
});
