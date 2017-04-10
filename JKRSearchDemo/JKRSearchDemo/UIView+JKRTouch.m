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

static const char * JKR_UN_TOUCH_KEY = "JKR_UN_TOUCH";
static const char * JKR_UN_TOUCH_RECT_KEY = "JKR_UN_TOUCH_RECT";

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(pointInside:withEvent:)), class_getInstanceMethod([UIView class], @selector(jkr_pointInside:withEvent:)));
}

- (void)setUnTouch:(BOOL)unTouch {
    objc_setAssociatedObject(self, JKR_UN_TOUCH_KEY, [NSNumber numberWithInt:unTouch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)unTouch {
    return objc_getAssociatedObject(self, JKR_UN_TOUCH_KEY) ? [objc_getAssociatedObject(self, JKR_UN_TOUCH_KEY) boolValue] : NO;
}

- (void)setUnTouchRect:(CGRect)unTouchRect {
    objc_setAssociatedObject(self, JKR_UN_TOUCH_RECT_KEY, [NSValue valueWithCGRect:unTouchRect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)unTouchRect {
    return objc_getAssociatedObject(self, JKR_UN_TOUCH_RECT_KEY) ? [objc_getAssociatedObject(self, JKR_UN_TOUCH_RECT_KEY) CGRectValue] : CGRectZero;
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
