class YoutubePlayer

  constructor: ->
    @init = false
    tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  createVideo: (id, videoId) ->
    return @play() if @init
    @videoId = videoId
    iOS =  if navigator.userAgent.match(/(iPad|iPhone|iPod)/g) then true else false
    events = { 'onReady': @play } if !iOS
    @player = new YT.Player id,
          height: '480'
          width: '800'
          playerVars: {rel: 0}
          videoId: @videoId
          events: events
    @init = true

  play: =>
    @player.playVideo()

  stop: ->
    @player.stopVideo()

window.YoutubePlayer = YoutubePlayer