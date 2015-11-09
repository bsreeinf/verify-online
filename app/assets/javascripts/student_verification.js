

$(document).on('page:change', function(event) {
  var MAX_FILE_SIZE = 512; //kB
  var table_data = [];
  var verification_amount = 0;
  var verification_amount_total = 0;
  
  var dataToSend = {};
  dataToSend["ids"] = [];
  dataToSend["verification_requests"] = []; 

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
    $("#college").val($("#rails-data").data("college-id"));
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

    var fr = new FileReader();
    fr.readAsDataURL(document.getElementById('verify_document').files[0]);
    fr.onloadend = function(){
      current_verification_stub['file_obj'] = b64toBlob(fr.result);
      console.log('file loaded on browser');  
    }
    
    current_verification_stub['file_name'] = ($('#verify_document')[0]).files[0].name;

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

    // Add dummy filenames
    // $('#verifications_tbody').append('<tr>'+
    //   '<input name="college_id" value="' + current_verification_stub['college_id'] + '" type="hidden"/>'+
    //   '<input name="student_name" value="' + current_verification_stub['name'] + '" type="hidden"/>'+
    //   '<input name="hallticket_no" value="' + current_verification_stub['hallticket_no'] + '" type="hidden"/>'+
    //   '</tr>');
    // $('#verify_document').appendTo("#verifications_tbody");
  });

  $("#btnProceedToPay").on('click', function(){
    $().fileUploadToS3();
  });

  $.fn.checkFileUploadStatus = function(){
    if(table_data.length == dataToSend["verification_requests"].length){
      console.log("AJAX call with");
      console.log(dataToSend);
      $.ajax({
        url: "/update_db",
        type: 'POST',
        data: JSON.parse(JSON.stringify(dataToSend)),
        context: document.body
        }).done(function(){
          // window.location.replace('/payment')
        }).always(function() {
          // Hide loader
        }
      );
    }
  }

  $.fn.fileUploadToS3 = function(){
    // var fileList = []
    for (var i = 0; i < table_data.length; i++) {
      // fileList[fileList.length] = new File([table_data[i]['file_obj']], table_data[i]['file_name']);
      // $("#rails-data").data("form")["college_id"] = table_data[i]['college_id'];

      $("body").fileupload({
        url:             $("#rails-data").data('url'),
        type:            'POST',
        autoUpload:       true,
        formData:         $("#rails-data").data('form'),
        paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
        dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
        replaceFileInput: false,
        progressall: function (e, data) {
           console.log(parseInt(data.loaded / data.total * 100, 10));
        },
        start: function (e) {
          console.log("started");
        },
        done: function(e, data) {
          console.log("Uploading done");
          // extract key and generate URL from response
          var key   = $(data.jqXHR.responseXML).find("Key").text();
          var url   = 'https://' + $("#rails-data").data('host') + '/' + key;
          console.log(data);
          var temp_college_id = key.split('/')[key.split('/').length-1].split("_")[0] + "";
          for (var j = 0; j < table_data.length; j++) {
            if(temp_college_id === table_data[j]['college_id']){
              dataToSend["ids"][dataToSend["ids"].length] = temp_college_id;
              var stub = [];
              stub['s3_url'] = url;
              stub['college_id'] = temp_college_id;
              stub['hallticket_no'] = table_data[j]['hallticket_no'];
              // stub['verification_amount'] = table_data[j]['verification_amount'];
              stub['name'] = table_data[j]['name'];
              dataToSend["verification_requests"][dataToSend["verification_requests"].length] = stub;
              $().checkFileUploadStatus();
            }
          }
          // create hidden field
          var input = $("<input />", { type:'hidden', name: 'file', value: url })
          console.log(url)
          //$("#rails-data").append(input);
        },
        fail: function(e, data) {
          console.log("failed");
        }
      });

      // Add files to be uploaded. This auto-uploads them .Given in initialization
      $("body").fileupload('add',{
        files: [new File([table_data[i]['file_obj']], table_data[i]['college_id'] + "_" + table_data[i]['file_name'])]}
      );
    }
  }
  
  $.fn.fileValidate = function(file, MAX_FILE_SIZE){
    if(file === undefined){
      console.log("No file selected");
      return false;
    }
    if(file.size > MAX_FILE_SIZE * 1024){
      console.log("File size exceeds limit : " + (file.size/1024) + "KB");
      return false;
    }
    return true;
  }

  function b64toBlob(b64DataString) {
    console.log("encoding b64DataString to Blob");
    console.log(b64DataString);
    var b64DataArray = b64DataString.split(";")
    var b64Data = b64DataArray[1].split(",")[1]
    var contentType = b64DataArray[0].split(":")[1]
    var sliceSize = 512;
      contentType = contentType || '';
      sliceSize = sliceSize || 512;

      var byteCharacters = atob(b64Data);
      var byteArrays = [];

      for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
          var slice = byteCharacters.slice(offset, offset + sliceSize);

          var byteNumbers = new Array(slice.length);
          for (var i = 0; i < slice.length; i++) {
              byteNumbers[i] = slice.charCodeAt(i);
          }

          var byteArray = new Uint8Array(byteNumbers);

          byteArrays.push(byteArray);
      }

      var blob = new Blob(byteArrays, {type: contentType});
      return blob;
  }
});
