//
//  UIColor+JKRColor.m
//  JKRAddressSelect
//
//  Created by Lucky on 2017/4/9.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "UIColor+JKRColor.h"

@implementation UIColor (JKRColor)

+ (UIColor *)jkr_colorWithHexString:(NSString *)hexString {
    CGFloat r, g, b, a;
    if (hexStringToRGBA(hexString, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

+ (UIColor *)jkr_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:red / 255.f green:green / 255.f blue:blue / 255.f alpha:alpha];
}

static inline NSUInteger hexStringToNSUInteger(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

static BOOL hexStringToRGBA(NSString *str, CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    NSUInteger length = [str length];
     //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStringToNSUInteger([str substringWithRange:NSMakeRange(0, 1)]) / 255.f;
        *g = hexStringToNSUInteger([str substringWithRange:NSMakeRange(1, 1)]) / 255.f;
        *b = hexStringToNSUInteger([str substringWithRange:NSMakeRange(2, 1)]) / 255.f;
        if (length == 4) *a = hexStringToNSUInteger([str substringWithRange:NSMakeRange(3, 1)]) / 255.f;
        else *a = 1;
    } else {
        *r = hexStringToNSUInteger([str substringWithRange:NSMakeRange(0, 2)]) / 255.f;
        *g = hexStringToNSUInteger([str substringWithRange:NSMakeRange(2, 2)]) / 255.f;
        *b = hexStringToNSUInteger([str substringWithRange:NSMakeRange(4, 2)]) / 255.f;
        if (length == 8) *a = hexStringToNSUInteger([str substringWithRange:NSMakeRange(6, 2)]) / 255.f;
        else *a = 1.f;
    }
    return YES;
}

@end
