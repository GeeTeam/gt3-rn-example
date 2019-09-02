//
//  GT3CaptchaManagerModule.m
//  GT3RNCaptchaModule
//
//  Created by Richard on 2019/8/18.
//  Copyright © 2019 Richard. All rights reserved.
//

#import "GT3CaptchaManagerModule.h"
#import "GT3CaptchaManager.h"
#import "GT3CaptchaManagerEmitter.h"
#import "RCTConvert+GT3LanguageType.h"

@interface GT3CaptchaManagerModule ()<GT3CaptchaManagerDelegate>

@property (nonatomic, strong) GT3CaptchaManager *manager;
@property (nonatomic, copy) RCTPromiseResolveBlock resolveBlock;
@property (nonatomic, copy) RCTPromiseRejectBlock rejectBlock;

@end


@implementation GT3CaptchaManagerModule

#pragma mark -- RN

  RCT_EXPORT_MODULE();

  RCT_EXPORT_METHOD(initWithAPI:(NSString *)api_1
                    API2:(NSString *)api_2){
      dispatch_async(dispatch_get_main_queue(), ^{
          self.manager = [GT3CaptchaManager sharedGTManagerWithAPI1:api_1 API2:api_2 timeout:8];
          self.manager.delegate = self;
        //必须调用, 用于注册获取验证初始化数据
          [self.manager registerCaptcha:nil];
        //[_manager enableDebugMode:YES];
        [self.manager useVisualViewWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
      });
  }

  RCT_REMAP_METHOD(startGTCaptcha,
                   resolve:(RCTPromiseResolveBlock)resolve
                   reject:(RCTPromiseRejectBlock)reject) {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.resolveBlock = resolve;
        self.rejectBlock = reject;
      [self.manager startGTCaptchaWithAnimated:YES];
    });
  }

  RCT_EXPORT_METHOD(useGTViewWithTimeout:(NSTimeInterval)timeout) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.manager useGTViewWithTimeout:timeout];
    });
  }

  RCT_EXPORT_METHOD(disableBackgroundUserInteraction:(BOOL)disable) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.manager disableBackgroundUserInteraction:disable];
    });
  }

  RCT_EXPORT_METHOD(enableDebug:(BOOL)enable) {
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.manager enableDebugMode:enable];
    });
  }

#pragma mark -- GT3CaptchaManagerDelegate For Emitter

- (void)gtCaptcha:(GT3CaptchaManager *)manager errorHandler:(GT3Error *)error {
  //处理验证中返回的错误
  if (error.code == -999) {
    // 请求被意外中断, 一般由用户进行取消操作导致, 可忽略错误
  }
  else if (error.code == -10) {
    // 预判断时被封禁, 不会再进行图形验证
  }
  else if (error.code == -20) {
    // 尝试过多
  }
  else {
    // 网络问题或解析失败, 更多错误码参考开发文档
  }
  NSMutableDictionary *map = [[NSMutableDictionary alloc]init];
  map[@"error_code"] = @(error.code);
//  [GT3CaptchaManagerEmitter gt3CaptchaDidReceiveErrorWithMap:map];
  if (self.rejectBlock) {
    self.rejectBlock(error.error_code,error.gtDescription,error.originalError);
  }
}

- (void)gtCaptcha:(GT3CaptchaManager *)manager didReceiveSecondaryCaptchaData:(NSData *)data response:(NSURLResponse *)response error:(GT3Error *)error decisionHandler:(void (^)(GT3SecondaryCaptchaPolicy))decisionHandler {
  

  NSMutableDictionary *map = [[NSMutableDictionary alloc]init];
  if (!error) {
    map[@"data"] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    map[@"secondaryCaptchaPolicy"] = @(GT3SecondaryCaptchaPolicyAllow);
    decisionHandler(GT3SecondaryCaptchaPolicyAllow);
  }
  else {
    map[@"error_code"] = error.error_code;
    map[@"gtDescription"] = error.gtDescription;
    map[@"secondaryCaptchaPolicy"] = @(GT3SecondaryCaptchaPolicyForbidden);
    decisionHandler(GT3SecondaryCaptchaPolicyForbidden);
  }
//  [GT3CaptchaManagerEmitter gt3CaptchaDidReceiveSecondaryCaptchaWithMap:map];
  if (self.resolveBlock) {
    self.resolveBlock(map);
  }
}

- (void)gtCaptchaUserDidCloseGTView:(GT3CaptchaManager *)manager {
  [GT3CaptchaManagerEmitter gt3CaptchaUserDidCloseGTView];
}

@end
