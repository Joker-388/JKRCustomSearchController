//
//  NSString+DCFontSize.h
//  JKRSearchDemo
//
//  Created by SnailChen on 2019/6/11.
//  Copyright © 2019年 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DCFontSize)


/**
 根据font 内容计算尺寸
 
 @param font 字体尺寸
 @param size 尺寸
 @return 计算size
 */
- (CGSize)dcSizeWithFont:(UIFont *)font MaxSize:(CGSize)size;

+ (CGSize)dcSizeWithString:(NSString *)str Font:(UIFont *)font MaxSize:(CGSize)size;

@end

