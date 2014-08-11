Shiftplan =
  initialize: ->
    $(document).on 'change', '#new_shiftplan [name="shiftplan[creation_type]"]', (e) =>
      @.observe();
    $(document).on 'change', '#new_shiftplan [name="shiftplan[range]"]', (e) =>
      @.observe();
    $( document ).ajaxComplete =>
      if $('#new_shiftplan').length > 0
        @.observe();

  observe: ->
    @_clearObjects()
    if @_getCreationType() == 'new'
      if @_getSelectedRange() == 'week'
        $obj = Datepicker.createDatePicker($('.shiftplan_starts_at'), {
            daysOfWeekDisabled: '0,2,3,4,5,6'
          })
        $obj.on 'changeDate', (e) ->
          $('#shiftplan_name').val("KW - #{moment(e.date).week()}")

      if @_getSelectedRange() == 'month'
        $obj = Datepicker.createDatePicker($('.shiftplan_starts_at'), {
            minViewMode: 1
          })
        $obj.on 'changeDate', (e) ->
          $('#shiftplan_name').val("#{moment(e.date).format('MMM - YY')}")

      if @_getSelectedRange() == 'free'
        $obj = Datepicker.createDatePicker($('.shiftplan_starts_at'))
        $endObj = Datepicker.createDatePicker($('.shiftplan_ends_at'))
        Datepicker.checkMinWith($obj, $endObj)

      $obj?.datepicker('show') if $('#spptModal')?.data('bs.modal')?.isShown

    else if @_getCreationType() == 'copy'
      @copyShiftplan()
      $(document).on 'change', '#shiftplan_copy_shiftplan', =>
        @copyShiftplan()


  copyShiftplan: ->
    @_clearObjects()
    $('[name="shiftplan[range]"]:checked').prop('checked', false)
    if $('#shiftplan_copy_shiftplan').val() != ''
      $('.copy-starts-at').slideDown(600)
      $('.copy-ends-at').slideDown(600)
      $obj = Datepicker.createDatePicker($('.shiftplan_starts_at'))
      $endObj = Datepicker.createDatePicker($('.shiftplan_ends_at'))
      Datepicker.checkMinWith($obj, $endObj)

      $obj.on 'changeDate', (e) =>
        $option = $('#shiftplan_copy_shiftplan option:selected')
        starts = $option.attr('data-starts')
        ends = $option.attr('data-ends')
        diff = moment.duration(moment(ends).diff(moment(starts))).asDays()
        $('.shiftplan_ends_at').datepicker('update', moment(e.date).add('d', diff).toDate())

    else
      $('.copy-starts-at').slideUp(600)
      $('.copy-ends-at').slideUp(600)



  _clearObjects: ->
    @_removeDatePicker($('.shiftplan_starts_at'))
    @_removeDatePicker($('.shiftplan_ends_at'))
    $('#shiftplan_name').val('')

  _removeDatePicker: ($obj) ->
    $obj.off('changeDate')
    $obj.data('datepicker')?.remove()
    $obj.val('')

  _getSelectedRange: ->
    $('[name="shiftplan[range]"]:checked').val()

  _getCreationType: ->
    $('[name="shiftplan[creation_type]"]:checked').val()

$ -> Shiftplan.initialize()