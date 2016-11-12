//
//  CRSafeTimer.m
//  HealthManage
//
//  Created by 曹然 on 2016/11/12.
//  Copyright © 2016年 应晓胜. All rights reserved.
//

#import "CRSafeTimer.h"
@interface CRSafeTimer ()


@property (nonatomic, assign) SEL selector;


@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, weak) id target;


@end
@implementation CRSafeTimer

- (void)run:(NSTimer *)timer {
    if (!self.target) {
        [self.timer invalidate];
    }else {
        [self.target performSelector:self.selector withObject:timer.userInfo];
    }
    
}
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)target
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                       repeats :(BOOL)repeats {
    CRSafeTimer *crTimer = [[CRSafeTimer alloc] init];
    crTimer.target = target;
    crTimer.selector = aSelector;
    crTimer.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                     target:crTimer
                                                   selector:@selector(run:)
                                                   userInfo:userInfo
                                                    repeats:repeats];
    return crTimer.timer;
}

@end
