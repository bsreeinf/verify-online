$(document).ready ->
  $('.search-field').bind 'keyup', ->
    dataString = undefined
    searchbox = undefined
    dataString = undefined
    searchbox = undefined
    dataString = undefined
    searchbox = undefined
    searchbox = $(this).val()
    dataString = 'name=' + searchbox
    if searchbox != ''
      $.ajax
        type: 'GET'
        url: 'colleges.json'
        data: dataString
        cache: false
        success: (response) ->
          $('#search-result').empty()
          i = 0
          $.each response, (i, obj) ->
            $('#search-result').append('<div id=search-result-' + i + '  class="display_box">' + obj['name'] + '</div>').show()
            i++
            $('#search-result-' + i).on 'click', ->
              console.log i + ' ' + obj['name']
              return
            return
            if i==0 then $('#search-result').empty().hide() else 0
          return
    else
      $('#search-result').empty().hide()
    false
  $(document).mouseup (e) ->
    container = $('#search-container')
    if !container.is(e.target) and container.has(e.target).length == 0
      $('#search-result').empty().hide()
    return
  return