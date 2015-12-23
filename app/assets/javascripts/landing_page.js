$(document).on('page:change', function() {

  $('.search-field').bind('focus', function() {
    $('.search-field').trigger('keyup');
  });

  $('.search-field').bind('keyup', function() {
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
    
    if (searchbox !== '') {
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
        
    } else {
      $('.college-box').show();
    }
    return false;
  });

  $('#verify-status').bind('submit', function(e) {
    e.preventDefault();
    var id = $('#everify')[0].value;
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

});