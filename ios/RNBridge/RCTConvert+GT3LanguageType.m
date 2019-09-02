//
//  RCTConvert+GT3LanguageType.m
//  GT3RNExample
//
//  Created by Richard on 2019/8/26.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "RCTConvert+GT3LanguageType.h"
#import "GT3Utils.h"

@implementation RCTConvert (GT3LanguageType)

  RCT_ENUM_CONVERTER(GT3LanguageType, (@{ @"gt3LANGTYPE_ZH_CN" : @(GT3LANGTYPE_ZH_CN),
                                          @"gt3LANGTYPE_ZH_TW" : @(GT3LANGTYPE_ZH_TW),
                                          @"gt3LANGTYPE_ZH_HK" : @(GT3LANGTYPE_ZH_HK),
                                          @"gt3LANGTYPE_KO_KR" : @(GT3LANGTYPE_KO_KR),
                                          @"gt3LANGTYPE_EN"    : @(GT3LANGTYPE_EN),
                                          @"gt3LANGTYPE_ID"    : @(GT3LANGTYPE_ID),
                                          @"gt3LANGTYPE_AR"    : @(GT3LANGTYPE_AR),
                                          @"gt3LANGTYPE_DE"    : @(GT3LANGTYPE_DE),
                                          @"gt3LANGTYPE_ES"    : @(GT3LANGTYPE_ES),
                                          @"gt3LANGTYPE_FR"    : @(GT3LANGTYPE_FR),
                                          @"gt3LANGTYPE_PT_PT" : @(GT3LANGTYPE_PT_PT),
                                          @"gt3LANGTYPE_RU"    : @(GT3LANGTYPE_RU),
                                          @"gt3LANGTYPE_AUTO"  : @(GT3LANGTYPE_AUTO)}),
                     GT3LANGTYPE_ZH_CN, integerValue)
  
@end
