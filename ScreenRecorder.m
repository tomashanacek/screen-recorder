//
//  ScreenRecorder.m
//  test
//
//  Created by Tomas Hanacek on 10/09/15.
//  Copyright (c) 2015 neco. All rights reserved.
//

#import "ScreenRecorder.h"
#import <AVFoundation/AVFoundation.h>


@interface ScreenRecorder () <AVCaptureFileOutputRecordingDelegate>

@end


@implementation ScreenRecorder {
    AVCaptureSession *_session;
    AVCaptureScreenInput *_input;
    AVCaptureDeviceInput *_audioInput;
    AVCaptureMovieFileOutput *_output;
    NSURL *_outputPath;
    void (^_completion)(BOOL);
}

- (id)initWithPath:(NSString *)outputPath andDisplayId:(CGDirectDisplayID)displayId
{
    self = [super init];

    if (self) {
        _session = [[AVCaptureSession alloc] init];

        _input = [[AVCaptureScreenInput alloc] initWithDisplayID:displayId];
        _output = [[AVCaptureMovieFileOutput alloc] init];

        _outputPath = [NSURL fileURLWithPath:outputPath];

        if ([_session canAddInput:_input]) {
            [_session addInput:_input];
        }

        if ([_session canAddOutput:_output]) {
            [_session addOutput:_output];
        }
    }

    return self;
}

- (void)recordAudio
{
    if (!_audioInput) {
        AVCaptureDevice *audioDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        _audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:nil];

        if ([_session canAddInput:_audioInput]) {
            [_session addInput:_audioInput];
        }
    }
}

- (void)setCapturesMouseClicks:(BOOL)capturesMouseClicks
{
    [_input setCapturesMouseClicks:capturesMouseClicks];
}

- (void)setCapturesCursor:(BOOL)capturesCursor
{
    [_input setCapturesCursor:capturesCursor];
}

- (void)setCropRect:(CGRect)cropRect
{
    [_input setCropRect:cropRect];
}

- (void)setFrameRate:(int)framerRate
{
    [_input setMinFrameDuration:CMTimeMake(1, (int32_t)framerRate)];
}

- (void)start
{
    [_session startRunning];
    [_output startRecordingToOutputFileURL:_outputPath recordingDelegate:self];
}

- (void)stop
{
    [_session stopRunning];
    [_output stopRecording];
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
}

- (void)dealloc
{
    [_session release];
    [_input release];
    [_output release];
    [_outputPath release];
    [super dealloc];
}

@end
