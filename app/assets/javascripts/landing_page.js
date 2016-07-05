$(document).on('change.rails', function() {
// $(document).delegate(rails.inputChangeSelector, 'change.rails', function(e) {
  console.log('aaa');
  $('#college-search').bind('focus', function() {
    $('.search-field').trigger('keyup');
  });

  $('#college-search').bind('keyup', function() {
    var dataString, searchbox;
    searchbox = $('.search-field').val();
    dataString = $("#colleges").data("url");
    console.log('keypress');
    
    if (searchbox !== '') {
      var arr = jQuery.grep(dataString, function( n, i ) {
        return n['name'].toLowerCase().indexOf(searchbox.toLowerCase()) == 0;
      });

      var i = 0;
      $('#search-result').empty();
      $.each(arr, function(i, obj) {
        $('#search-result').append(
          '<div data-url="' + i + '" class="display_box search-result" style="padding: 0;">' +
            '<a class="search-result-acnhor" href="/apply?college_id=' + obj['id'] + '&college_name=' + obj['name'] + '">' + obj['name'] + 
            '</a></div>').show();
        i++;
        $('#search-result-' + i).on('click', function() {
          console.log(i + ' ' + obj['name']);
        });
        return;
        if (i === 0) {
          return $('#search-result').empty().hide();
        } else {
          return 0;
        }
      });
        
    } else {
      $('#search-result').empty().hide();
    }
    return false;
  });

  // $(document).mouseup(function(e) {
  //   var container;
  //   container = $('#search-field');
  //   if (!container.is(e.target) && container.has(e.target).length === 0) {
  //     $('#search-result').empty().hide();
  //   }
  // });

  // Search page code

  $('.search-field-main').bind('keyup', function() {
    var dataString, searchbox;
    searchbox = $('.search-field-main').val();
    dataString = $("#colleges").data("url");
    console.log('keypress main');
    
    // if (searchbox !== '') {
      console.log('search not empty')
      var arr = jQuery.grep(dataString, function( n, i ) {
        return n['name'].toLowerCase().indexOf(searchbox.toLowerCase()) >=0 ;
      });

      $.each($('.college-box'),function(i, ele){
        var boxCollegeId = $(ele).data("college-id");
        var hasMatch = false;
        $.each(arr, function(k, obj){
          if(obj.id == boxCollegeId)
            hasMatch = true;
        });
        if(hasMatch)
          $(ele).show();
        else
          $(ele).hide();
      });

      //re fresh tile spacing
      initWorkFilter();
        
    // } else {
    //   $.each($('.college-box'),function(i, ele){
    //     $(ele).show();
    //   });
    // }
    return false;
  });

  $('#verify-status').bind('submit', function(e) {
    e.preventDefault();
    var id = $('#everify')[0].value;
    if(id != ''){
      $('#e_verification_loader').fadeIn(50);
    
      $.ajax({
        type: 'GET',
        url: 'verification_status.json?id=' + id,
        cache: false,
      })
          .done( function(response) {
            response = response.landing_page[0];
            console.log(response);
            if(typeof response === 'undefined'){
              $('#ev_success_content').hide();
              $('#ev_verify_status').html("Verification ID <strong>" + $('#everify')[0].value + "</strong> is <strong>INVALID</strong>");
            }else { 
              $('#ev_success_content').show();
              $('#ev_verify_status').html("Verification ID <strong>" + $('#everify')[0].value + "</strong> is <strong>VALID</strong>");
              $('#ev_name').text(response.name + "");
              $('#ev_hallticket_no').text(response.hallticket_no + "");
            }
            $("#eVerifyModal").modal();
          })

          .always( function(response) {
            $('#e_verification_loader').fadeOut(50);
      });
    
    }
  
  });

});