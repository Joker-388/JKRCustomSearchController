//
//  AppDelegate+JKRRootViewController.m
//  JKRSearchDemo
//
//  Created by Lucky on 2017/4/4.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "AppDelegate+JKRRootViewController.h"
#import "JKRTabBarController.h"

@implementation AppDelegate (JKRRootViewController)

- (void)jkr_configRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    JKRTabBarController *tabBarController = [[JKRTabBarController alloc] init];
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}

@end
