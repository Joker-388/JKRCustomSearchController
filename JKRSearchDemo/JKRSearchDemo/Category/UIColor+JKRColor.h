//
//  UIColor+JKRColor.h
//  JKRAddressSelect
//
//  Created by Lucky on 2017/4/9.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JKRColor)

+ (UIColor *)jkr_colorWithHexString:(NSString *)hexString;
+ (UIColor *)jkr_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

@end
