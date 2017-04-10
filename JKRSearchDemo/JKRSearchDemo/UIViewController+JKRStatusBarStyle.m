
//
//  UIViewController+JKRStatusBarStyle.m
//  JKRTest
//
//  Created by Joker on 2016/5/7.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import "UIViewController+JKRStatusBarStyle.h"
#import <objc/runtime.h>

@implementation UIViewController (JKRStatusBarStyle)

static const char * JKR_STATUS_BAR_LIGHT_KEY = "JKR_STATUS_LIGHT";

- (void)setJkr_lightStatusBar:(BOOL)jkr_lightStatusBar {
    objc_setAssociatedObject(self, JKR_STATUS_BAR_LIGHT_KEY, [NSNumber numberWithInt:jkr_lightStatusBar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)jkr_lightStatusBar {
    return objc_getAssociatedObject(self, JKR_STATUS_BAR_LIGHT_KEY) ? [objc_getAssociatedObject(self, JKR_STATUS_BAR_LIGHT_KEY) boolValue] : NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.jkr_lightStatusBar ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

@end
