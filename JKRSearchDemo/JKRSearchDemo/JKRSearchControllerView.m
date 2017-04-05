//
//  JKRSearchControllerView.m
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/5.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRSearchControllerView.h"

@implementation JKRSearchControllerView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [super hitTest:point withEvent:event];
}

/// 解决弹出SearchViewController的View之后，挡住了searchBar的touch响应
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (point.y < 64) {
        return NO;
    } else {
        return [super pointInside:point withEvent:event];
    }
}

@end
