$ ->
  $( document ).ajaxError ( event, jqxhr, settings, thrownError ) ->
    if jqxhr.status == 401
      val =  jqxhr.responseJSON?['error']
      val ||= jqxhr.responseText
      bootbox.alert val, ->
        window.location.href = '/login'

