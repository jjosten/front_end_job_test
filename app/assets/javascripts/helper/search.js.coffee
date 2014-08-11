
$ ->
  $(document).on "keyup", ".search-user #calendar_employee_search", (evt) ->
    $target = $(evt.currentTarget)
    stuff = jQuery(@).val().toLowerCase()
    if stuff != ""
      $target.closest('.search-user').find(".list-box").each ->
        if jQuery(@).find(".name").html().toLowerCase().indexOf(stuff) isnt -1
          jQuery(@).show()
        else
          jQuery(@).hide()
    else
      $("#aside_employee_list .list-box").show()
    false

