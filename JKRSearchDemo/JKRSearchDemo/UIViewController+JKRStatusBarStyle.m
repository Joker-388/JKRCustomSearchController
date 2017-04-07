
//
//  UIViewController+JKRStatusBarStyle.m
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/7.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "UIViewController+JKRStatusBarStyle.h"
#import <objc/runtime.h>

@implementation UIViewController (JKRStatusBarStyle)

- (void)setJkr_lightStatusBar:(BOOL)jkr_lightStatusBar {
    objc_setAssociatedObject(self, @"JKR_STATUS_LIGHT", [NSNumber numberWithInt:jkr_lightStatusBar], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)jkr_lightStatusBar {
    return objc_getAssociatedObject(self, @"JKR_STATUS_LIGHT") ? [objc_getAssociatedObject(self, @"JKR_STATUS_LIGHT") boolValue] : NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.jkr_lightStatusBar ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

@end
