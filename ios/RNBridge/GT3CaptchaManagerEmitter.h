//
//  GT3CaptchaManagerEmmiter.h
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
   该类负责OC端向JS端通信
*/

NS_ASSUME_NONNULL_BEGIN

@interface GT3CaptchaManagerEmitter : RCTEventEmitter <RCTBridgeModule>

/**
 极验验证错误结果信息回调

 @param map 错误信息接
 */
+ (void)gt3CaptchaDidReceiveErrorWithMap:(NSDictionary *)map;


/**
 二次验证

 @param map 二次验证返回的数据包装的字典，包含error_code、二次验证返回结果
 @param decisionHandler 二次验证发生错误的回调
 */
+ (void)gt3CaptchaDidReceiveSecondaryCaptchaWithMap:(NSDictionary *)map;


/**
 *  @abstract 是否使用内部默认的API1请求逻辑
 *
 *  @param manager 验证管理器
 */
//+ (void)gt3shouldUseDefaultRegisterAPIWithMap:(NSDictionary *)map;

/**
 *  @abstract 将要向<b>API1</b>发送请求的时候调用此方法, 通过此方法可以修改将要发送的请求
 *
 *  @param map 回调参数集合
 */
//+ (void)gt3WillSendRequestAPI1WithMap:(NSDictionary *)map;

/**
 *  @abstract 当接收到从<b>API1</b>的数据, 通知返回字典, 包括<b>gt_public_key</b>,
 *  <b>gt_challenge</b>, <b>gt_success_code</b>
 *  @param map 回调参数集合
 */
//+ (void)gt3DidReceiveDataFromAPI1WithMap:(NSDictionary *)map;

/**
 *  @abstract 通知接收到返回的验证交互结果
 *
 *  @discussion 此方法仅仅是前端返回的初步结果, 并非验证最终结果。
 *
 *  @param map 回调参数集合
 */
//+ (void)gt3DidReceiveCaptchaCodeWithMap:(NSDictionary *)map;

/**
 *  @abstract 是否使用内部默认的API2请求逻辑
 *
 *  @discussion 默认返回YES;
 *
 *  @param map 回调参数集合， YES使用,NO不使用
 */
//+ (void)gt3ShouldUseDefaultSecondaryValidateWithMap:(NSDictionary *)map;

/**
 *  @abstract 通知即将进行二次验证, 再次修改发送至<b>API2</b>的验证。
 *  @param map 回调参数集合
 */
//+ (void)gt3WillSendSecondaryCaptchaRequestWithMap:(NSDictionary *)map;

/**
 close极验验证View回调
 */
+ (void)gt3CaptchaUserDidCloseGTView;

@end

NS_ASSUME_NONNULL_END
