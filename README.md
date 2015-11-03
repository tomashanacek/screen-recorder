# Screen recorder

OS X screen recording library for Node

## Installation

```
npm install screen-recorder
```

## Example

```
var ScreenRecorder = require('screen-recorder').ScreenRecorder
var path = require('path')

var movie = new ScreenRecorder(path.resolve(__dirname, 'test.mp4')) // [, displayId]
movie.setCapturesMouseClicks(true)
movie.setCropRect(0, 0, 500, 500)
movie.setFrameRate(30) // default is 15
movie.recordAudio()
movie.start()

setTimeout(function() {
  movie.stop()
}, 10000)
```
