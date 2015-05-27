ScreenRecorder = require './'
path = require 'path'

movie = new ScreenRecorder(path.resolve(__dirname, 'test.mp4'))
movie.setCapturesMouseClicks(true)
movie.setCropRect(0, 0, 500, 500)
movie.start()

setTimeout ->
  movie.stop()
, 10000
