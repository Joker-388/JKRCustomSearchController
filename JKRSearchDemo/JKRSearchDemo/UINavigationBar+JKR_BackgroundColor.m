//
//  UINavigationBar+JKR_BackgroundColor.m
//  JKRSearchDemo
//
//  Created by Lucky on 2017/4/4.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "UINavigationBar+JKR_BackgroundColor.h"
#import "UIView+JKRTouch.h"
#import <objc/runtime.h>

@implementation UINavigationBar (JKR_BackgroundColor)

static UIView *_jkr_backgroundView;

+ (void)load {
    _jkr_backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, kScreenWidth, 64)];
    _jkr_backgroundView.unTouch = YES;
    method_exchangeImplementations(class_getInstanceMethod([UINavigationBar class], NSSelectorFromString(@"layoutSubviews")), class_getInstanceMethod([UINavigationBar class], @selector(jkr_layoutSubviews)));
}

- (void)setJkrBackroundColor:(UIColor *)jkrBackroundColor {
    objc_setAssociatedObject(self, "JKR_NAVBAR_BG_COLOR", jkrBackroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self insertSubview:_jkr_backgroundView atIndex:0];
    _jkr_backgroundView.backgroundColor = jkrBackroundColor;
}

- (UIColor *)jkrBackroundColor {
    return objc_getAssociatedObject(self, "JKR_NAVBAR_BG_COLOR");
}

- (void)jkr_layoutSubviews {
    [self jkr_layoutSubviews];
    [self sendSubviewToBack:_jkr_backgroundView];
}

@end
