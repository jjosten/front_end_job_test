## Some JS helpers that may make your life simpler :)
## by twetzel

@to_currency = ( number ) ->
  unless isNaN number
    (Math.round( parseFloat( number ) * 100 ) / 100).toFixed(2)
  else
    (0).toFixed(2)

@to_euro = (number) ->
  "#{to_currency(number)} €"

@to_dollar = (number) ->
  "$ #{to_currency(number)}"


@getInt = (number) ->
  parseInt(number || 0) || 0
@getFloat = (number) ->
  parseFloat(number || 0) || 0


logPrefix =  null
trace = if (App?.Environment == "development") then true else false

@log = (args...) ->
  return unless trace
  if logPrefix then args.unshift( logPrefix )
  console?.log?(args...)
  @


Array::removeEmpties = ->
  newArray = []
  index = 0
  while index < @length
    newArray.push @[index] if @[index]
    index++
  newArray


moment.lang( I18n.locale )

$ ->
  $(".timeago").each ->
    date = moment( $(@).text() )
    $(@).attr("data-date", $(@).text()).attr("title", date.format("llll") ).html( date.fromNow() )

