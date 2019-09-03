//
//  ViewController.m
//  gt-captcha3-ios-example
//
//  Created by NikoXu on 17/02/2017.
//  Copyright © 2017 Xniko. All rights reserved.
//

#import "LoginViewController.h"
#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //rootViewController是OC的，依赖注入方式加载JS
    NSURL *jsCodeLocation;
    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"LoginPage"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    self.view = rootView;
}

- (void)viewWillLayoutSubviews {
  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.view endEditing:YES];
}

@end
