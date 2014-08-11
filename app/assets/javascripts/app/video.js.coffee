$ ->
  @youtubePlayer = new YoutubePlayer()
  @player = null
  $('.video_button').click =>
    @youtubePlayer.createVideo("video_iframe", 'oPjRzbp1M6c')
    $('.video_overlay').show()

  $('.landing_video_background').click =>
    $('.video_overlay').hide()
    @youtubePlayer.stop()


