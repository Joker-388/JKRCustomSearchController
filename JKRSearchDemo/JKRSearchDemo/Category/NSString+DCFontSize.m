//
//  NSString+DCFontSize.m
//  JKRSearchDemo
//
//  Created by SnailChen on 2019/6/11.
//  Copyright © 2019年 Lucky. All rights reserved.
//

#import "NSString+DCFontSize.h"

@implementation NSString (DCFontSize)

- (CGSize)dcSizeWithFont:(UIFont *)font MaxSize:(CGSize)size {
    
    NSDictionary *attrs = @{ NSFontAttributeName : font };
    return  [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

+ (CGSize)dcSizeWithString:(NSString *)str Font:(UIFont *)font MaxSize:(CGSize)size{
    
    NSDictionary *attrs = @{ NSFontAttributeName : font };
    
    return [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
