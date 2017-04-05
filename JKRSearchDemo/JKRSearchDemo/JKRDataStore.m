//
//  JKRDataStore.m
//  JKRSearchBar
//
//  Created by tronsis_ios on 17/3/31.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRDataStore.h"

@implementation JKRDataStore

static JKRDataStore *__store;

+ (void)initialize {
    __store = [[JKRDataStore alloc] init];
}

+ (instancetype)sharedStore {
    return __store;
}

- (instancetype)init {
    self = [super init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"country" ofType:@"txt"];
    NSError *error;
    NSString *countriesString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (!error) self.dataArray = [countriesString componentsSeparatedByString:@"\n"];
    return self;
}

@end
