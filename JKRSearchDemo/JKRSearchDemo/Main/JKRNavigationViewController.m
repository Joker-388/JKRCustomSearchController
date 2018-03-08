//
//  JKRNavigationViewController.m
//  JKRSearchDemo
//
//  Created by Lucky on 2017/4/4.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRNavigationViewController.h"
#import "UINavigationBar+JKR_BackgroundColor.h"

@interface JKRNavigationViewController ()

@end

@implementation JKRNavigationViewController

+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"Navbar"] forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = [UIImage new];
    navigationBar.jkrBackroundColor = JKRColor(74, 74, 74, 1.0);
    navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.childViewControllers.firstObject;
}

@end
