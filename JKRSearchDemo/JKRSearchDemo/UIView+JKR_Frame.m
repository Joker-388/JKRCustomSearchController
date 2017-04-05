//
//  UIView+JKR_Frame.m
//  JKRDemo
//
//  Created by Lucky on 14/7/12.
//  Copyright © 2014年 Lucky. All rights reserved.
//

#import "UIView+JKR_Frame.h"

@implementation UIView (JKR_Frame)

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setOrigan:(CGPoint)origan {
    CGRect frame = self.frame;
    frame.origin = origan;
    self.frame = frame;
}

- (CGPoint)origan {
    return self.frame.origin;
}

@end
