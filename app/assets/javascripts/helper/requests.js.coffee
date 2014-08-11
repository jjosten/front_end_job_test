shiftStaffRequest = ( url ) ->
  $.ajax
    type: "GET"
    dataType: 'script'
    url: url
    success: ( data, textStatus, jqXHR ) ->
      log? data
      return
    error: (jqXHR, textStatus, errorThrown) ->
      alert errorThrown
      return


staffRequest = ( url, staffID, userId, positionId, locationId, jQueryObj = null ) ->
  $.ajax
    type: "POST"
    dataType: 'script'
    #headers: { "X-CSRF-Token": $("meta[name=csrf-token]").attr("content") }
    url: url
    data: { staff_id: staffID, user_id: userId, position_id: positionId, location_id: locationId }
    success: ( data, textStatus, jqXHR ) ->
      log? data
      if jQueryObj
        jQueryObj.trigger('ajax_success')
      return
    error: (jqXHR, textStatus, errorThrown) ->
      alert errorThrown
      if jQueryObj
        jQueryObj.trigger('ajax_error')
      return


@addShiftStaff = ( staff, shift ) ->
  shiftStaffRequest( "/shifts/#{shift}/add-staff/#{staff.staff}" )

@dropShiftStaff = ( staff, shift ) ->
  shiftStaffRequest( "/shifts/#{shift}/drop-staff/#{staff.staff}" )


@setStaff = ( staffID, userId, positionId, locationId, jQueryObj = null ) ->
  staffRequest( "/positions/set_staff", staffID, userId, positionId, locationId, jQueryObj)

@removeStaff = ( staffID, userId, positionId, locationId, jQueryObj = null ) ->
  staffRequest( "/positions/remove_staff", staffID, userId, positionId, locationId, jQueryObj)