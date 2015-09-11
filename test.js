var ScreenRecorder = require('./').ScreenRecorder;
var path = require('path');
var movie = new ScreenRecorder(path.resolve(__dirname, 'test.mp4'));
movie.setCapturesMouseClicks(true);
movie.setCropRect(0, 0, 500, 500)
movie.start();

setTimeout(function() {
  movie.stop();
}, 5000)
