DependentHide=
  initialize: ->
    @.observeLinks()
    $( document ).ajaxComplete =>
      @.observeLinks();

  observeLinks: ->
    $('.dependent-hide').each (e, obj) =>
      $obj = $(obj)
      if $obj.data('dependent-show-on')?
        @showObject($obj)
      else if $obj.data('dependent-hide-on')?
        @hideObject($obj)

  hideObject: ($obj) ->
    $targetObj = @_getTargetObject($obj)
    @_hideCurrentObj($obj, $targetObj)
    $targetObj.on 'change', =>
      @_hideCurrentObj($obj, $targetObj)

  _hideCurrentObj: (curentObj, targetObj) ->
    val = @_checkExist(@targetVal(curentObj, targetObj), curentObj.data('dependent-show-on'))
    if val
        @_hide(curentObj)
    else
      @_show(curentObj)

  _hide: (obj) ->
    obj.slideUp(600)

  _show: (obj) ->
    obj.slideDown(600)

  showObject: ($obj) ->
    $targetObj = @_getTargetObject($obj)
    @_showCurrentObj($obj, $targetObj)
    $targetObj.on 'change', =>
      @_showCurrentObj($obj, $targetObj)

  _showCurrentObj: (curentObj, targetObj) ->
    val = @_checkExist(@targetVal(curentObj, targetObj), curentObj.data('dependent-show-on'))
    if val
      @_show(curentObj)
    else
      @_hide(curentObj)

  _getTargetObject: ($obj) ->
    if(t = $obj.data('dependent-on-name'))?
      return $("[name='#{t}']")
    else if(t = $obj.data('dependent-on-id'))?
      return $("##{t}")
    else if(t = $obj.data('dependent-on-class'))?
      return $(".#{t}")

  _checkExist: (targetVal, curentVal) ->
    switch $.type(curentVal)
      when 'string'
        targetVal == String(curentVal)
      when 'array'
        $.inArray(targetVal, curentVal ) >= 0
      else
        false

  targetVal: (curentObj, targetObj) ->
    if(t = curentObj.data('dependent-target'))?
      $(t).val()
    else
      $(targetObj).val()

$ -> DependentHide.initialize()

window.DependentHide = DependentHide;
