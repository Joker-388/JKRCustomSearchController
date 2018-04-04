//
//  JKRSearchController.m
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/5.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRSearchController.h"

#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)

/// navigaionbar高度
#define kSafeAreaNavHeight (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO) ? 88 : 64)

NSString *SEARCH_CANCEL_NOTIFICATION_KEY = @"SEARCH_CANCEL_NOTIFICATION_KEY";

@interface JKRSearchController ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation JKRSearchController

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController {
    self = [super init];
    self.searchResultsController = searchResultsController;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgView];
    self.view.unTouchRect = CGRectMake(0, 0, self.view.width, kSafeAreaNavHeight);
    self.searchResultsController.view.frame = self.bgView.bounds;
    [self.bgView addSubview:self.searchResultsController.view];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endSearch) name:SEARCH_CANCEL_NOTIFICATION_KEY object:nil];
}

- (void)tapSearchBarAction {
    if ([self.delegate respondsToSelector:@selector(willPresentSearchController:)]) [self.delegate willPresentSearchController:self];
    self.searchBar.jkr_viewController.jkr_lightStatusBar = NO;
    [self.searchBar addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handGesture)]];
    [self.searchBar addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handGesture)]];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.view];
    if ([self.delegate respondsToSelector:@selector(didPresentSearchController:)]) [self.delegate didPresentSearchController:self];
    [self.searchBar setValue:@1 forKey:@"isEditing"];
    if (self.searchBar.jkr_viewController.parentViewController && [self.searchBar.jkr_viewController.parentViewController isKindOfClass:[UINavigationController class]] && self.hidesNavigationBarDuringPresentation) {
        [(UINavigationController *)self.searchBar.jkr_viewController.parentViewController setNavigationBarHidden:YES animated:YES];
        [UIView animateWithDuration:0.2 animations:^{
            self.bgView.y = kSafeAreaNavHeight;
        }];
    } else {
        
    }
}

- (void)handGesture {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"] && [self.searchResultsUpdater respondsToSelector:@selector(updateSearchResultsForSearchController:)]) {
        [self.searchResultsUpdater updateSearchResultsForSearchController:self];
    }
}

- (void)endSearch {
    if ([self.delegate respondsToSelector:@selector(willDismissSearchController:)]) [self.delegate willDismissSearchController:self];
    self.searchBar.jkr_viewController.jkr_lightStatusBar = YES;
    NSArray *searchBarGestures = self.searchBar.gestureRecognizers;
    if (searchBarGestures.count == 3) {
        [self.searchBar removeGestureRecognizer:searchBarGestures.lastObject];
        [self.searchBar removeGestureRecognizer:searchBarGestures.lastObject];
    }
    if (searchBarGestures.count == 2) {
        [self.searchBar removeGestureRecognizer:searchBarGestures.lastObject];
    }
    
    [self.view removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(didDismissSearchController:)]) [self.delegate didDismissSearchController:self];
    [self.searchBar setValue:@0 forKey:@"isEditing"];
    if (self.searchBar.jkr_viewController.parentViewController && [self.searchBar.jkr_viewController.parentViewController isKindOfClass:[UINavigationController class]] && self.hidesNavigationBarDuringPresentation) {
        [(UINavigationController *)self.searchBar.jkr_viewController.parentViewController setNavigationBarHidden:NO animated:YES];
        self.bgView.y = CGRectGetMaxY(self.searchBar.frame) + kSafeAreaNavHeight;
    } 
}

- (void)endSearchTextFieldEditing:(UITapGestureRecognizer *)sender {
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
        _bgView.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame) + kSafeAreaNavHeight, kScreenWidth, kScreenHeight - self.searchBar.frame.size.height - (iPhoneX ? 44 : 20));
        _bgView.backgroundColor = [UIColor lightGrayColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endSearchTextFieldEditing:)];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        [_bgView addGestureRecognizer:tapGestureRecognizer];
    }
    return _bgView;
}

- (void)dealloc {
    [self.searchBar removeObserver:self forKeyPath:@"text"];
    NSLog(@"JKRSearchController dealloc");
}

@end
