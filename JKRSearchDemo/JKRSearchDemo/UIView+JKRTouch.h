//
//  UIView+JKRTouch.h
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/6.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JKRTouch)

// 是否能够响应touch事件
@property (nonatomic, assign) BOOL unTouch;
// 不响应touch事件的区域
@property (nonatomic, assign) CGRect unTouchRect;

@end
