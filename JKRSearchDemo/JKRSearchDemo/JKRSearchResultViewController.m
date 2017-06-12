//
//  JKRSearchResultViewController.m
//  JKRSearchBar
//
//  Created by tronsis_ios on 17/3/31.
//  Copyright © 2017年 tronsis_ios. All rights reserved.
//

#import "JKRSearchResultViewController.h"

@interface JKRSearchResultViewController ()

@end

@implementation JKRSearchResultViewController

static NSString *const cellID = @"RESULT_CELL_ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

- (void)setFilterDataArray:(NSArray *)filterDataArray {
    _filterDataArray = filterDataArray;
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filterDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = self.filterDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"ResultTableView click index: %zd", indexPath.row);
}

- (void)dealloc {
    NSLog(@"JKRSearchResultViewController dealloc");
}

@end
