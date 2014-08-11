$ ->
  $('.add_users').click (evt)->
    $element = $(evt.currentTarget)

    staffs = $element.closest('.employee-dropbox').attr('data-staff').split(",")

    $body = $($element.html())

    $body.find('.list-box').each (index, box) =>
      box = $(box)
      if jQuery.inArray( box.data('staff').toString() , staffs ) >= 0
        $ele = box.find('.circleBase')
        $ele.removeClass('add_user btn-success').addClass('remove_user btn-danger')
        $ele.find('span').removeClass('glyphicon-plus').addClass('glyphicon-minus')
      else
        $ele = box.find('.circleBase')
        $ele.removeClass('remove_user btn-danger').addClass('add_user btn-success')
        $ele.find('span').removeClass('glyphicon-minus').addClass('glyphicon-plus')

    $body.addClass('show').removeClass('hide')

    modal = $("#spptModal")
    view = renderView("shared/modal_content", {title: "", content: $body[0].outerHTML})
    modal.find(".modal-content").html($(view))
    modal.modal("show")

  $('.modal').on 'click', '.add_user', (evt) ->
    $ele = $(evt.currentTarget)
    data = $ele.data();
    setStaff(data['staff'], data['user'], data['position'], data['location'], $ele)
    $ele.on 'ajax_success', ->
      $ele.removeClass('add_user btn-success').addClass('remove_user btn-danger')
      $ele.find('span').removeClass('glyphicon-plus').addClass('glyphicon-minus')

      $obj = $(@).clone()
      $obj.remove('button')
      that = $(@).data()
      $parent_window = $(".employee-dropbox[data-position='#{$(@).data('position')}']");
      that.el_id = "#{$parent_window.attr("id")}-#{$(@).attr("data-id")}"
      that.position = $parent_window.attr("data-position")
      that.location = $parent_window.attr("data-location")
      emp = renderView( "shared/staff_droped", staff: that, content: $(@).parent('.list-box').html() )
      if $("##{that.el_id}").length == 0
        addDragStaff( $parent_window, $obj)
        $( emp ).appendTo($parent_window).draggable
          appendTo: "body"
          helper: "clone"
      $ele.off 'ajax_success'

  $('.modal').on 'click', '.remove_user', (evt) ->
    $ele = $(evt.currentTarget)
    data = $ele.data();
    removeStaff(data['staff'], data['user'], data['position'], data['location'], $ele)
    $ele.on 'ajax_success', ->
      $ele.removeClass('remove_user btn-danger').addClass('add_user btn-success')
      $ele.find('span').removeClass('glyphicon-minus').addClass('glyphicon-plus')

      $box = $(".employee-dropbox[data-position='#{$(@).data('position')}']");
      $element = $("##{$box.attr("id")}-#{$(@).attr("data-id")}")
      $element.remove()
      $element.remove() if $element.hasClass("removable")
      removeDragStaff( $box, $element )
      clearDropBoxStates()
      $ele.off 'ajax_success'