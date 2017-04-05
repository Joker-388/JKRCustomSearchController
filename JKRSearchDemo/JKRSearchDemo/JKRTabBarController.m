//
//  JKRTabBarController.m
//  JKRSearchDemo
//
//  Created by Lucky on 2017/4/4.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRTabBarController.h"
#import "JKRNavigationViewController.h"
#import "JKRRootViewController.h"
#import "JKRContactsViewController.h"
#import "JKRFindViewController.h"
#import "JKRMeViewController.h"

@interface JKRTabBarController ()

@end

@implementation JKRTabBarController

+ (void)initialize {
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JKRColor(143, 143, 147, 1.0)} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:JKRColor(52, 179, 25, 1.0)} forState:UIControlStateSelected];
    UITabBar *tabBar = [UITabBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    tabBar.backgroundImage = [UIImage imageNamed:@"tabbarBkg"];
}

- (instancetype)init {
    self = [super init];
    [self _addChildViewController];
    return self;
}

- (void)_addChildViewController {
    [self addChildViewController:[[JKRRootViewController alloc] init] withTitle:@"微信" image:[UIImage imageNamed:@"tabbar_mainframe"] selectedImage:[UIImage imageNamed:@"tabbar_mainframeHL"]];
    [self addChildViewController:[[JKRContactsViewController alloc] init] withTitle:@"通讯录" image:[UIImage imageNamed:@"tabbar_contacts"] selectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]];
    [self addChildViewController:[[JKRFindViewController alloc] init] withTitle:@"发现" image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discoverHL"]];
    [self addChildViewController:[[JKRMeViewController alloc] init] withTitle:@"我" image:[UIImage imageNamed:@"tabbar_me"] selectedImage:[UIImage imageNamed:@"tabbar_meHL"]];
}

- (void)addChildViewController:(UIViewController *)childController withTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    [childController.tabBarItem setImage:image];
    [childController.tabBarItem setSelectedImage:selectedImage];
    childController.tabBarItem.title = title;
    childController.navigationItem.title = title;
    JKRNavigationViewController *navigationViewController = [[JKRNavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:navigationViewController];
}

@end
