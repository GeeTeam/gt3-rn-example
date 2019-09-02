//
//  GT3CaptchaManagerEmmiter.m
//  GT3RNCaptchaModule
//
//  Created by Richard on 2019/8/18.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "GT3CaptchaManagerEmitter.h"

/// 这是JS外部识别的OC回调方法事件名字
NSString *const GT3CaptchaErrorHandlerEvent = @"GT3CaptchaErrorHandlerEvent";
NSString *const GT3DidReceiveSecondaryCaptchaDataEvent = @"GT3DidReceiveSecondaryCaptchaDataEvent";
NSString *const GT3CaptchaUserDidCloseGTViewEvent = @"userCloseCaptchaView";

/// 这是和上面方法名字一一对应的回调事件通知
NSString *const GT3CaptchaErrorHandlerNotification = @"GT3CaptchaErrorHandlerNotification";
NSString *const GT3DidReceiveSecondaryCaptchaDataNotification = @"GT3DidReceiveSecondaryCaptchaDataNotification";
NSString *const GT3CaptchaUserDidCloseGTViewNotification = @"userCloseCaptchaViewNotification";


/// 方法名字的key
NSString *const EmitterName = @"emitterName";

#define EmitterEventNames @[GT3CaptchaErrorHandlerEvent,\
                            GT3DidReceiveSecondaryCaptchaDataEvent,\
                            GT3CaptchaUserDidCloseGTViewEvent]

#define EmitterEventNotifications @[GT3CaptchaErrorHandlerNotification,\
                                    GT3DidReceiveSecondaryCaptchaDataNotification,\
                                    GT3CaptchaUserDidCloseGTViewNotification]

@implementation GT3CaptchaManagerEmitter

RCT_EXPORT_MODULE();

/**
 这个方法返回一个RN回调事件的名称数组。有多少个事件，就写多少个名称。RN通过这些监听事件，从而实现IOS原生平台向RN发送事件。
 */
- (NSArray<NSString *> *)supportedEvents{
    return EmitterEventNames;
}

- (void)startObserving {
    [EmitterEventNotifications enumerateObjectsUsingBlock:^(NSString * name, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emitterEvent:) name:name object:nil];
    }];
}

- (void)stopObserving {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)emitterEvent:(NSNotification *)notification {
    NSString *emitterName = notification.userInfo[EmitterName];
    NSLog(@"emitterName => %@",emitterName);
    NSDictionary *dic = notification.userInfo[@"map"];
    [self sendEventWithName:emitterName body:dic];
}

+ (void)gt3CaptchaDidReceiveErrorWithMap:(NSDictionary *)map {
  NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
  dic[EmitterName] = GT3CaptchaErrorHandlerEvent;
  dic[@"map"] = map;
  [[NSNotificationCenter defaultCenter] postNotificationName:GT3CaptchaErrorHandlerNotification
                                                      object:self userInfo:@{EmitterName:GT3CaptchaErrorHandlerEvent}];
}

+ (void)gt3CaptchaDidReceiveSecondaryCaptchaWithMap:(NSDictionary *)map {
  NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
  dic[EmitterName] = GT3DidReceiveSecondaryCaptchaDataEvent;
  dic[@"map"] = map;
  [[NSNotificationCenter defaultCenter] postNotificationName:GT3DidReceiveSecondaryCaptchaDataNotification
                                                      object:self userInfo:dic];
}

+ (void)gt3CaptchaUserDidCloseGTView {
  [[NSNotificationCenter defaultCenter] postNotificationName:GT3CaptchaUserDidCloseGTViewNotification                                                  object:self userInfo:@{EmitterName:GT3CaptchaUserDidCloseGTViewEvent}];
}

@end
