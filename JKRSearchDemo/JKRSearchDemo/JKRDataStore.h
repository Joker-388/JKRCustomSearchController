//
//  JKRDataStore.h
//  JKRSearchBar
//
//  Created by tronsis_ios on 17/3/31.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JKRDataStore : NSObject

@property (nonatomic, strong) NSArray<NSString *> *dataArray;
+ (instancetype)sharedStore;

@end
