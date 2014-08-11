#http://bootstrap-datepicker.readthedocs.org/en/release

Datepicker =
  FORMAT: "dd.mm.yyyy"

  initialize: ->
    @.observe()
    $( document ).ajaxComplete =>
      @.observe();

  observe: ->
    $('.datepicker').each (index, obj) =>
      @createDatePicker($(obj))

  createDatePicker: ($obj, options = {}) ->
    defaultOptions = {
      format: @FORMAT
      autoclose: true
      calendarWeeks: true
      weekStart: 1
      language: I18n.locale
      beforeShowDay: (date) => @renderDates(date, @startDate($obj)) if @startDate($obj)
    }

    $obj.datepicker($.extend(defaultOptions, options))
    @checkMinWith($obj)
    $obj

  checkMinWith: ($obj, min_with) ->
    min_obj = $obj.attr('less_than')
    min_obj ||= min_with
    if min_obj
      $obj.on 'changeDate', (ev) =>
        $min_obj = $(min_obj)
        $min_obj_date = $min_obj.data('datepicker')
        newDate = new Date(ev.date)
        newDate.setDate(newDate.getDate());
        $min_obj_date.setStartDate(newDate);
        $min_obj.focus()
        $obj.datepicker('hide')

  show: ($obj) ->
    $obj.datepicker("show");

  renderDates: (date, start_date) ->
    return if date.valueOf() < start_date.valueOf() then false else true;

  startDate: ($obj) ->
    return new Date($obj.attr('start_date')) if $obj.attr('start_date')
    return $($obj.attr('greater_than')).data('datepicker').getDate() if $obj.attr('greater_than')
    return null


window.Datepicker = Datepicker

$ -> Datepicker.initialize()
