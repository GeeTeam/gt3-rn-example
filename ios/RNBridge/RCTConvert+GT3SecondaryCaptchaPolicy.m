//
//  RCTConvert+GT3SecondaryCaptchaPolicy.m
//  GT3RNExample
//
//  Created by Richard on 2019/8/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCTConvert+GT3SecondaryCaptchaPolicy.h"
//#import "GT3Utils.h"
#import <GT3Captcha/GT3Captcha.h>


@implementation RCTConvert (GT3SecondaryCaptchaPolicy)

  RCT_ENUM_CONVERTER(GT3SecondaryCaptchaPolicy, (@{@"secondaryCaptchaPolicyAllow" : @(GT3SecondaryCaptchaPolicyAllow),
                                                   @"secondaryCaptchaPolicyForbidden" : @(GT3SecondaryCaptchaPolicyForbidden)}),
                     GT3SecondaryCaptchaPolicyAllow, integerValue)
                                                 
@end
