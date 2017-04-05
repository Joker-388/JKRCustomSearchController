//
//  JKRSearchController.m
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/5.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRSearchController.h"
#import "JKRSearchControllerView.h"

NSString *SEARCH_CANCEL_NOTIFICATION_KEY = @"SEARCH_CANCEL_NOTIFICATION_KEY";

@interface JKRSearchController ()

@property (nonatomic, strong) JKRSearchControllerView *searchBackgroundView;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation JKRSearchController

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController {
    self = [super init];
    self.searchResultsController = searchResultsController;
    return self;
}

- (void)loadView {
    self.view = self.searchBackgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgView];
    self.searchResultsController.view.frame = self.bgView.bounds;
    [self.bgView addSubview:self.searchResultsController.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endSearch) name:SEARCH_CANCEL_NOTIFICATION_KEY object:nil];
}

- (void)tapSearchBarAction {
    self.searchBar.jkr_viewController.jkr_lightStatusBar = NO;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.view];
    [self.searchBar setValue:@1 forKey:@"isEditing"];
    if (self.searchBar.jkr_viewController.parentViewController && [self.searchBar.jkr_viewController.parentViewController isKindOfClass:[UINavigationController class]] && self.hidesNavigationBarDuringPresentation) {
        [(UINavigationController *)self.searchBar.jkr_viewController.parentViewController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:0.2 animations:^{
            self.bgView.y = 64;
        }];
    } else {
        
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"] && [self.searchResultsUpdater respondsToSelector:@selector(updateSearchResultsForSearchController:)]) {
        [self.searchResultsUpdater updateSearchResultsForSearchController:self];
    }
}

- (void)endSearch {
    self.searchBar.jkr_viewController.jkr_lightStatusBar = YES;
    [self.view removeFromSuperview];
    [self.searchBar setValue:@0 forKey:@"isEditing"];
    if (self.searchBar.jkr_viewController.parentViewController && [self.searchBar.jkr_viewController.parentViewController isKindOfClass:[UINavigationController class]] && self.hidesNavigationBarDuringPresentation) {
        [(UINavigationController *)self.searchBar.jkr_viewController.parentViewController setNavigationBarHidden:NO animated:YES];
        self.bgView.y = CGRectGetMaxY(self.searchBar.frame) + 64;
    } 
}

- (void)endSearchTextFieldEditing {
    UITextField *searchTextField = [self.searchBar valueForKey:@"searchTextField"];
    [searchTextField resignFirstResponder];
}

- (JKRSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[JKRSearchBar alloc] init];
        [_searchBar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearchBarAction)]];
        [_searchBar addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _searchBar;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame) + 64, kScreenWidth, kScreenHeight - self.searchBar.frame.size.height);
        _bgView.backgroundColor = [UIColor lightGrayColor];
        [_bgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endSearchTextFieldEditing)]];
    }
    return _bgView;
}

- (JKRSearchControllerView *)searchBackgroundView {
    if (!_searchBackgroundView) {
        _searchBackgroundView = [[JKRSearchControllerView alloc] init];
        _searchBackgroundView.frame = [UIScreen mainScreen].bounds;
    }
    return _searchBackgroundView;
}

@end
