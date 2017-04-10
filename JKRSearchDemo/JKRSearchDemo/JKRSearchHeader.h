//
//  JKRSearchHeader.h
//  JKRSearchDemo
//
//  Created by Lucky on 2017/4/4.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#ifndef JKRSearchHeader_h
#define JKRSearchHeader_h
#import "UIColor+JKRColor.h"
#define JKRColor(r,g,b,a) [UIColor jkr_colorWithRed:r green:g blue:b alpha:a]
#define JKRColorHex(_hex_) [UIColor jkr_colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#import "UIView+JKRViewController.h"
#import "UIView+JKR_Frame.h"
#import "UIViewController+JKRStatusBarStyle.h"
#import "UIView+JKRTouch.h"
#import "UIView+JKRSubView.h"
#import "UIGestureRecognizer+JKRTouch.h"

#endif /* JKRSearchHeader_h */
