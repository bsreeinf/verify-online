$(document).on('page:change', function() {

  $('.search-field').bind('focus', function() {
    $('.search-field').trigger('keyup');
  });

  $('.search-field-main').bind('focus', function() {
    $('.search-field-main').trigger('keyup');
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
            '<a style="color: #444; text-decoration: none; padding: 10px; display: block;" ' +
            'href="/apply?college_id=' + obj['id'] + '&college_name=' + obj['name'] + '">' + obj['name'] + 
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

  $(document).mouseup(function(e) {
    var container;
    container = $('#search-field');
    if (!container.is(e.target) && container.has(e.target).length === 0) {
      $('#search-result').empty().hide();
    }
  });
});