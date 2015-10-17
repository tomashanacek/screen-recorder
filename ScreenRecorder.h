//
//  ScreenRecorder.h
//  test
//
//  Created by Tomas Hanacek on 10/09/15.
//  Copyright (c) 2015 neco. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenRecorder : NSObject

- (id)initWithPath:(NSString *)outputPath;
- (void)start;
- (void)stop;
- (void)setCapturesMouseClicks:(BOOL)capturesMouseClicks;
- (void)setCapturesCursor:(BOOL)capturesCursor;
- (void)setCropRect:(CGRect)cropRect;
- (void)setFrameRate:(int)framerRate;

@end
