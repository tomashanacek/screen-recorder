//
//  ScreenRecorder.h
//  test
//
//  Created by Tomas Hanacek on 10/09/15.
//  Copyright (c) 2015 neco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenRecorder : NSObject

- (id)initWithPath:(NSString *)outputPath andDisplayId:(CGDirectDisplayID)displayId;
- (void)start;
- (void)stop;
- (void)recordAudio;
- (void)setCapturesMouseClicks:(BOOL)capturesMouseClicks;
- (void)setCapturesCursor:(BOOL)capturesCursor;
- (void)setCropRect:(CGRect)cropRect;
- (void)setFrameRate:(int)framerRate;

@end
