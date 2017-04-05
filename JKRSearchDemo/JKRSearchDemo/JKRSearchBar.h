//
//  JKRSearchBar.h
//  JKRSearchDemo
//
//  Created by Joker on 2017/4/5.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKRSearchBar;

@protocol JKRSearchBarDelegate <NSObject>

@optional
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchTex;

@end

@interface JKRSearchBar : UIView

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, weak) id<JKRSearchBarDelegate> delegate;
@property (nonatomic, strong) NSString *text;

@end
