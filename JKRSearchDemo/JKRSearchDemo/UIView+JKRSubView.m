//
//  UIView+JKRSubView.m
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/10.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "UIView+JKRSubView.h"

@implementation UIView (JKRSubView)

- (UITableView *)tableView {
    NSArray *subViews = self.subviews;
    if (!subViews || subViews.count == 0) return nil;
    for (UIView *view in subViews) {
        if ([view isKindOfClass:[UITableView class]]) return (UITableView *)view;
    }
    return nil;
}

@end
