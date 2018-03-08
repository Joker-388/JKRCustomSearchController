//
//  JKRSearchController.h
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/5.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKRSearchBar.h"
@class JKRSearchController;

@protocol JKRSearchControllerDelegate <NSObject>

@optional
- (void)willPresentSearchController:(JKRSearchController *)searchController;
- (void)didPresentSearchController:(JKRSearchController *)searchController;
- (void)willDismissSearchController:(JKRSearchController *)searchController;
- (void)didDismissSearchController:(JKRSearchController *)searchController;

@end

@protocol JKRSearchControllerhResultsUpdating <NSObject>

@required
- (void)updateSearchResultsForSearchController:(JKRSearchController *)searchController;

@end

@interface JKRSearchController : UIViewController

@property (nonatomic, strong) JKRSearchBar *searchBar;
@property (nonatomic, assign) BOOL hidesNavigationBarDuringPresentation;
@property (nonatomic, weak) id<JKRSearchControllerDelegate> delegate;
@property (nonatomic, weak) id<JKRSearchControllerhResultsUpdating> searchResultsUpdater;
@property (nonatomic, strong) UIViewController *searchResultsController;

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController;

@end
