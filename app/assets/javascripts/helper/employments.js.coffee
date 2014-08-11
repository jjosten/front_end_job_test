###

  Drag and Drop for Position Page

###

$ ->

  $(".dragable").draggable
    appendTo: "body"
    helper: "clone"

  #$(".list-box.dragable").draggable
  #  appendTo: "body"
  #  helper: "clone"
  #$(".employee-btn.dragable").draggable
  #  appendTo: "body"
  #  helper: "clone"

  $(".employee-dropbox").droppable
    activeClass: "ui-state-default"
    hoverClass: "ui-state-hover"

    accept: (drager) ->
      # console.log "drager: ", drager.attr("class"), drager.hasClass("modalDragger")
      # console.log "this: ", $(this).attr("class")
      return false if drager.hasClass("ui-sortable-helper")
      return false if drager.hasClass("modalDragger")
      # return false if drager[0].classList.contains("modalDragger")
      if drager.hasClass("removable") and
      drager.attr("data-position") == $(this).attr("data-position") and
      drager.attr("data-location") == $(this).attr("data-location") or
      !drager.hasClass("removable") and
      $(this).attr("data-staff")?.split(",").indexOf( drager.attr("data-staff") ) is -1
        return true
      else
        return false

    drop: (event, ui) ->
      #return false  if ui.draggable.is(".dropped")
      ui.helper.data('out', false)
      $(this).find(".placeholder").remove()
      that = ui.draggable.data()
      that.el_id = "#{$(this).attr("id")}-#{ui.draggable.attr("data-id")}"
      that.position = $(this).attr("data-position")
      that.location = $(this).attr("data-location")
      emp = renderView( "shared/staff_droped", staff: that, content: ui.draggable.html() )
      if $("##{that.el_id}").length == 0
        setStaff( ui.draggable.attr("data-staff"), ui.draggable.attr("data-user"), $(this).attr("data-position"), $(this).attr("data-location") )
        addDragStaff( $(this), ui.draggable )
        $( emp ).appendTo(this).draggable
          appendTo: "body"
          helper: "clone"
      return

    deactivate: ( event, ui ) ->
      if ui.helper.data('out')
        removeStaff( ui.helper.attr("data-staff"), ui.helper.attr("data-user"), ui.helper.attr("data-position"), ui.helper.attr("data-location") )
        ui.helper.remove()
        ui.draggable.remove() if ui.draggable.hasClass("removable")
        removeDragStaff( $(this), ui.draggable )
        clearDropBoxStates()

    out: (event, ui) ->
      ui.helper.data('out', true)
