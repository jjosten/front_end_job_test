###

  Drag and Drop for Staff-Modal

###
$ ->

  $("#spptModal").on "shown.bs.modal", ->

    $('.sp-tooltip').tooltip({ placement: "top" })

    $(".colorPicker").colorPicker onSelect: (ui, c) ->
      ui.css "background", c
      ui.prev(".color-inpt").val c
      return

    $('.sp-tooltip').tooltip({ placement: "top" })

    $("#spptModal .employee-btn.dragable").draggable
      appendTo: "body"
      helper: "clone"

    $("#spptModal #shift_staff_dropbox").droppable
      activeClass: "ui-state-default"
      hoverClass: "ui-state-hover"

      accept: (drager) ->
        return false unless drager.hasClass("modalDragger")
        if $(this).attr("data-staff")?.indexOf( drager.attr("data-staff") ) is -1 and
        getInt( $(this).attr("data-open-slots") ) > 0 or
        drager.hasClass("removable")
          return true
        else
          return false

      drop: (event, ui) ->
        ui.helper.data('out', false)
        log "Modal DropIn: ", ui.draggable.attr("data-name")
        $(this).find(".placeholder").remove()
        self = $(this).data()
        that = ui.draggable.data()
        box = $(this)
        that.el_id = "#{$(this).attr("data-id")}-#{ui.draggable.attr("data-id")}"
        that.position = $(this).attr("data-position")
        that.location = $(this).attr("data-location")
        if $("##{that.el_id}").length == 0
          console.log "droped: ", that, self
          emp = renderView( "shared/staff_droped", staff: that, content: ui.draggable.html(), style: "modalDragger" )
          addShiftStaff( that, $(this).attr("data-shift") )
          $("#calendar").fullCalendar('refetchEvents')
          addDragStaff(box, ui.draggable)
          decreaseDragSlots(box)
          box.find(".employee-btn.empty").first().replaceWith(" ")
          $( emp ).appendTo(this).draggable
            appendTo: "body"
            helper: "clone"

      deactivate: ( event, ui ) ->
        if ui.helper.data('out')
          if ui.draggable.hasClass("removable")
            box = $(this)
            that = ui.draggable.data()
            dropShiftStaff( that, box.attr("data-shift") )
            box.append( $( renderView("shared/staff_empty") ).removeClass("fc") )
            ui.helper.remove()
            ui.draggable.remove() if ui.draggable.hasClass("removable")
            removeDragStaff( box, ui.draggable )
            increaseDragSlots(box)
            $("#calendar").fullCalendar('refetchEvents')
            clearDropBoxStates()

      out: (event, ui) ->
        ui.helper.data('out', true)
