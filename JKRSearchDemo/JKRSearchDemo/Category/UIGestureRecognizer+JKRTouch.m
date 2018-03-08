//
//  UIGestureRecognizer+JKRTouch.m
//  JKRTouchDemo
//
//  Created by Joker on 2016/12/31.
//  Copyright © 2016年 Lucky. All rights reserved.
//

#import "UIGestureRecognizer+JKRTouch.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import <objc/runtime.h>

@interface UIGestureRecognizer ()<UIGestureRecognizerDelegate>

@end

@implementation UIGestureRecognizer (JKRTouch)

static const char * JKR_GESTURE_UN_TOUCH_KEY = "JKR_GESTURE_UN_TOUCH_KEY";

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod([UIGestureRecognizer class], @selector(initWithTarget:action:)), class_getInstanceMethod([UIGestureRecognizer class], @selector(jkr_initWithTarget:action:)));
}

- (instancetype)jkr_initWithTarget:(id)target action:(SEL)action {
    UIGestureRecognizer *gestureRecognizer = [self jkr_initWithTarget:target action:action];
    gestureRecognizer.delegate = self;
    return gestureRecognizer;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return !self.unTouch;
}

- (BOOL)unTouch {
    return objc_getAssociatedObject(self, JKR_GESTURE_UN_TOUCH_KEY) ? [objc_getAssociatedObject(self, JKR_GESTURE_UN_TOUCH_KEY) boolValue] : NO;
}

- (void)setUnTouch:(BOOL)unTouch {
    objc_setAssociatedObject(self, JKR_GESTURE_UN_TOUCH_KEY, [NSNumber numberWithInt:unTouch], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
