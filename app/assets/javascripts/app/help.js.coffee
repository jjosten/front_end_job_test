$ ->
  count = 1
  $('.help_window').ready ->
    $('.help_overlay').hide()
    $(".show_#{count}").show()

  $('.help_window').click (evt) ->
    count += 1
    $('.help_overlay').hide()
    $(".show_#{count}").show()
    if count > $('.help_overlay').length
      $(@).hide()
      $('.help_overlay').hide()

  $('.help_window .remove').click (eve) ->
    $(@).closest('.help_window').hide()
    $('.help_overlay').hide()
    eve.stopPropagation()
