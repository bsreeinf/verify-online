

$(document).on('page:change', function(event) {
  var MAX_FILE_SIZE = 512; //kB
  var table_data = new Array();
  var verification_amount = 0;
  var verification_amount_total = 0;
  
  var dataToSend = {};
  dataToSend["ids"] = [];
  dataToSend["verification_requests"] = []; 

  // Helper methods

  // Validates if file exists and filesize < MAX_FILE_SIZE
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


  // Make AJAX call to get verification amount and display it below select box.
  // Handles loader also.
  $.fn.loadVerificationAmount = function(id){
    if(id != ''){
      $('#verification_amount_loader').fadeIn(50);
    
      $.ajax({
        type: 'GET',
        url: 'colleges/' + id + '.json',
        cache: false,
      })
          .done( function(response) {
            verification_amount = response.verification_amount;
            $('#verification_amount_lable').text(verification_amount + "");
          })

          .always( function(response) {
            $('#verification_amount_loader').fadeOut(50);
      });
    
    } else {
    
      verification_amount = 0;
      $('#verification_amount_lable').text(verification_amount + "");
    }
  
  }


  // Converts base64 string to Blob
  $.fn.b64toBlob = function(b64DataString) {
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

  $.fn.updateVerificationAmountLabel = function(){
    verification_amount_total += verification_amount;
    $('#verification_amount_total_lable').text(Math.round(verification_amount_total * 1.05) + "");
  }

  // End of Helper methods



  // Update verification amount when a college is selected from select box
  $('#college').on('change', function() {
    $().loadVerificationAmount($('#college')[0].value);
  });

  // Set default college if set in GET parameters. Check $('#rails-data') element for this.
  $("#college").val($("#rails-data").data("college-id"));
  $("#college").trigger('change');

  // Prevent form submit and locally cache data so that it can be posted later.
  $('#form').on('submit', function(event){
    event.preventDefault();

    var fr = new FileReader();
    var verification_stub = new Array();
    
    // Validate file nil and filesize manually.
    if(!$.fn.fileValidate($('#verify_document')[0].files[0])){
      console.log('File validation failed.');
      return;
    }
    
    verification_stub['college_id'] = $('#college')[0].value;
    verification_stub['college_name'] = $("#college option")[$("#college")[0].selectedIndex].text
    verification_stub['verification_amount'] = verification_amount;
    verification_stub['name'] = $('#name').val();
    verification_stub['hallticket_no'] = $('#hallticket_no').val();
    verification_stub['file_link'] = URL.createObjectURL(($('#verify_document')[0]).files[0]);
    verification_stub['file_name'] = ($('#verify_document')[0]).files[0].name;
    
    fr.readAsDataURL(document.getElementById('verify_document').files[0]);
    fr.onloadend = function(){
      verification_stub['file_obj'] = $().b64toBlob(fr.result);
    }

    table_data.push(verification_stub);
    
    $().updateVerificationAmountLabel();

    // reset fields
    verification_amount = 0;
    $('#verification_amount_lable').text(verification_amount + "");
    $("#form").trigger('reset');

    // add row to table
    $('#verifications_tbody').append('<tr>'+
      '<td>' + verification_stub['college_name'] + '</td>' + 
      '<td>' + verification_stub['name'] + '</td>' + 
      '<td>' + verification_stub['hallticket_no'] + '</td>' + 
      '<td><a href="' + verification_stub['file_link'] + '" target="blank"><i class="fa fa-download dark"></i></a></td>' + 
      '<td>Rs ' + verification_stub['verification_amount'] + '</td>' + 
      '</tr>');

    // Add dummy filenames
    // $('#verifications_tbody').append('<tr>'+
    //   '<input name="college_id" value="' + verification_stub['college_id'] + '" type="hidden"/>'+
    //   '<input name="student_name" value="' + verification_stub['name'] + '" type="hidden"/>'+
    //   '<input name="hallticket_no" value="' + verification_stub['hallticket_no'] + '" type="hidden"/>'+
    //   '</tr>');
    // $('#verify_document').appendTo("#verifications_tbody");
  });

  $("#btnProceedToPay").on('click', function(){
    $().fileUploadToS3();
  });

  $.fn.checkFileUploadStatus = function(numFilesUploaded){
    if(table_data.length == numFilesUploaded){

      console.log("All data collected until now. Use this to create form and execute a submit --> ");
      console.log(table_data);

      // $.ajax({
      //   url: "/update_db",
      //   type: 'POST',
      //   data: JSON.parse(JSON.stringify(dataToSend)),
      //   context: document.body
      //   }).done(function(){
      //     // window.location.replace('/payment')
      //   }).always(function() {
      //     // Hide loader
      //   }
      // );
    }
  }

  $.fn.fileUploadToS3 = function(){
    var numFilesUploaded = 0;

    console.log("All data collected until now.");
    console.log(table_data);

    for(var i = 0; i < table_data.length; i++) {

      // Initialize file upload to S3. 
      // NOTE: doesn't start the upload since no files have been provided yet
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
          var temp_college_id = key.split('/')[key.split('/').length-1].split("_")[0] + "";

          console.log(data);

          // save new file URL from S3 in the stub
          for(var j = 0; j < table_data.length; j++){
            table_data[j]['document_link'] = url;
          }

          // Check if all files have been uploaded and proceed accordingly
          $().checkFileUploadStatus(++numFilesUploaded);

          console.log(url)
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
  
  

  
});
