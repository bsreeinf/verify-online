  $(document).on('page:change', function(event) {   


  $('.search-field').bind('keyup', function() {
    var collegeData, searchbox;
    dataString = void 0;
    searchbox = void 0;
    searchbox = $(this).val();
    dataString = $("#colleges").data("url");
    
    if (searchbox !== '') {
      var arr = jQuery.grep(dataString, function( n, i ) {
        // console.log(searchbox.toLowerCase() + ' ' + n['name'].toLowerCase())
        return n['name'].toLowerCase().indexOf(searchbox.toLowerCase()) == 0;

      });
      // console.log(dataString)
      // console.log(arr)

      var i;
      $('#search-result').empty();
      i = 0;
      $.each(arr, function(i, obj) {
        $('#search-result').append(
          '<div data-url="' + i + '" class="display_box search-result">' +
            '<a style="color: #444; text-decoration: none;" ' +
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

      $('.search-result').bind('click', function() {
        var collegeId = $(this).data("url");

      });
        
    } else {
      $('#search-result').empty().hide();
    }
    return false;
  });
  $(document).mouseup(function(e) {
    var container;
    container = $('#search-container');
    if (!container.is(e.target) && container.has(e.target).length === 0) {
      $('#search-result').empty().hide();
    }
  });
});