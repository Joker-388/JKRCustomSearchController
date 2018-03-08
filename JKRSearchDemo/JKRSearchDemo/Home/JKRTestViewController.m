//
//  JKRTestViewController.m
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/6.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRTestViewController.h"
#import "JKRRootViewController.h"

@interface JKRTestViewController ()

@end

@implementation JKRTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.navigationController pushViewController:[JKRRootViewController new] animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
