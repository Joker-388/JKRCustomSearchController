//
//  JKRSearchTextField.m
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/5.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRSearchTextField.h"

@implementation JKRSearchTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.canTouch = YES;
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL result = [super pointInside:point withEvent:event];
    if (_canTouch) {
        return result;
    } else {
        return NO;
    }
}

- (void)dealloc {
    NSLog(@"JKRSearchTextField dealloc");
}

@end
