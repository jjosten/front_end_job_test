@clearDropBoxStates = ->
  $(".ui-droppable.ui-state-default").removeClass("ui-state-default")
  $(".ui-droppable.ui-state-hover").removeClass("ui-state-hover")


@removeDragStaff = (box, draggable) ->
  array = $(box).attr("data-staff").split(",")
  index = array.indexOf( getInt($(draggable).attr("data-staff")) )
  array.splice(index, 1) if index > -1
  index = array.indexOf( $(draggable).attr("data-staff").toString() )
  array.splice(index, 1) if index > -1
  $(box).attr("data-staff", array.removeEmpties().join(","))


@addDragStaff = (box, draggable) ->
  array = $(box).attr("data-staff").split(",")
  array.push getInt($(draggable).attr("data-staff")) 
  $(box).attr("data-staff", array.removeEmpties().join(","))


@decreaseDragSlots = (box) ->
  open_slots = parseInt( $(box).attr( "data-open-slots" ) ) - 1
  $(box).attr( "data-open-slots", open_slots )

@increaseDragSlots = (box) ->
  open_slots = parseInt( $(box).attr( "data-open-slots" ) ) + 1
  $(box).attr( "data-open-slots", open_slots )