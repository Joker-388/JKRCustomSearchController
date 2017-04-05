//
//  JKRRootViewController.m
//  JKRSearchDemo
//
//  Created by Lucky on 2017/4/4.
//  Copyright © 2017年 Lucky. All rights reserved.
//

#import "JKRRootViewController.h"
#import "JKRSearchController.h"
#import "JKRSearchResultViewController.h"
#import "JKRDataStore.h"

@interface JKRRootViewController ()<UITableViewDataSource, UITableViewDelegate, JKRSearchControllerhResultsUpdating>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JKRSearchController *searchController;
@property (nonatomic, strong) NSArray<NSString *> *dataArray;

@end

@implementation JKRRootViewController

static NSString *const CellIdentifier = @"WEICHAT_ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    self.jkr_lightStatusBar = YES;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)updateSearchResultsForSearchController:(JKRSearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    if (!(searchText.length > 0)) return;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)", searchText];
    JKRSearchResultViewController *resultController = (JKRSearchResultViewController *)searchController.searchResultsController;
    resultController.filterDataArray = [self.dataArray filteredArrayUsingPredicate:predicate];
}

#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    }
    return _tableView;
}

- (JKRSearchController *)searchController {
    if (!_searchController) {
        JKRSearchResultViewController *resultSearchController = [[JKRSearchResultViewController alloc] init];
        _searchController = [[JKRSearchController alloc] initWithSearchResultsController:resultSearchController];
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchResultsUpdater = self;
    }
    return _searchController;
}

- (NSArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [JKRDataStore sharedStore].dataArray;
    }
    return _dataArray;
}

@end
