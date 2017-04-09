//
//  UIView+JKRTouch.m
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/6.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "UIView+JKRTouch.h"
#import <objc/runtime.h>

@implementation UIView (JKRTouch)

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(pointInside:withEvent:)), class_getInstanceMethod([UIView class], @selector(jkr_pointInside:withEvent:)));
}

- (void)setUnTouch:(BOOL)unTouch {
    objc_setAssociatedObject(self, "JKR_UN_TOUCH", [NSNumber numberWithInt:unTouch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)unTouch {
    return objc_getAssociatedObject(self, "JKR_UN_TOUCH") ? [objc_getAssociatedObject(self, "JKR_UN_TOUCH") boolValue] : NO;
}

- (void)setUnTouchRect:(CGRect)unTouchRect {
    objc_setAssociatedObject(self, "JKR_UN_TOUCH_RECT", [NSValue valueWithCGRect:unTouchRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)unTouchRect {
    return objc_getAssociatedObject(self, "JKR_UN_TOUCH_RECT") ? [objc_getAssociatedObject(self, "JKR_UN_TOUCH_RECT") CGRectValue] : CGRectZero;
}

- (BOOL)jkr_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.unTouch) return NO;
    if (self.unTouchRect.origin.x == 0 && self.unTouchRect.origin.y == 0 && self.unTouchRect.size.width == 0 && self.unTouchRect.size.height == 0) {
        return [self jkr_pointInside:point withEvent:event];
    } else {
        if (CGRectContainsPoint(self.unTouchRect, point)) return NO;
        else return [self jkr_pointInside:point withEvent:event];
    }
}

@end
