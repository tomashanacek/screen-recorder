$ = require 'nodobjc'
$.framework 'AVFoundation'
$.framework 'Foundation'


class ScreenRecorder

  constructor: (outputPath = null) ->
    @_pool = $.NSAutoreleasePool('alloc')('init')
    @_session = $.AVCaptureSession('alloc')('init')

    # set input
    @_displayId = $.CGMainDisplayID()
    @_input = $.AVCaptureScreenInput('alloc')('initWithDisplayID', @_displayId)

    # set output
    @_output = $.AVCaptureMovieFileOutput('alloc')('init')

    # add input and output to session
    if @_session('canAddInput', @_input)
      @_session('addInput', @_input)

    if @_session('canAddOutput', @_output)
      @_session('addOutput', @_output)

    if outputPath
      @setOutputPath(outputPath)

  setOutputPath: (outputPath) ->
    outputPathString = $.NSString('stringWithUTF8String', outputPath)
    @_outputPath = $.NSURL('fileURLWithPath', outputPathString)

  setCapturesMouseClicks: (value) ->
    @_input('setCapturesMouseClicks', value)

  setCapturesCursor: (value) ->
    @_input('setCapturesCursor', value)

  setCropRect: (x, y, width, height) ->
    @_input('setCropRect', $.CGRectMake(x, y, width, height))

  start: ->
    @_session('startRunning')
    @_output(
      'startRecordingToOutputFileURL', @_outputPath,
      'recordingDelegate', @_output
    )

  stop: ->
    @_session('stopRunning')
    @_output('stopRecording')
    @_pool('drain')

module.exports = ScreenRecorder
