//
//  GT3CaptchaManagerModule.h
//  GT3RNCaptchaModule
//
//  Created by Richard on 2019/8/18.
//  Copyright © 2019 Richard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>
#import <React/RCTEventEmitter.h>


/**
 该类负责JS端向OC端通信,m文件中export的方法在JS端可以直接调用
 */

NS_ASSUME_NONNULL_BEGIN

@interface GT3CaptchaManagerModule : NSObject <RCTBridgeModule>

@end

NS_ASSUME_NONNULL_END
