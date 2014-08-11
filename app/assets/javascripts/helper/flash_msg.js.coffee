$ ->
  
  if jQuery("#flash_msg div").length > 0
    noticeTimer = setTimeout(->
      $("#flash_msg div").slideUp();
    , 3500)
  
  