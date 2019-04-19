//
//  NSTimer+BlocksSupport.m
//  MCSimpleAudioPlayerDemo
//
//  Created by Chengyin on 15-3-13.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NSTimer+BlocksSupport.h"
#import "YFCate.h"

@implementation NSTimer (BlocksSupport)
+ (NSTimer*)timerWith:(NSTimeInterval)interval block:(void(^)(void))block repeats:(BOOL)repeats
{
    NSTimer *timer = [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(bs_blockInvoke:) userInfo:[block copy] repeats:repeats];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (void)bs_blockInvoke:(NSTimer*)timer
{
    void (^block)(void) = timer.userInfo;
    if (block)
    {
        block();
    }
}
@end
