# JKRCustomSearchController
[![preview](https://travis-ci.org/Joker-388/MessageImageCategory.svg?branch=master)](http://www.jianshu.com/u/95d5ea0acd19)&nbsp;<br><br>
[![preview](https://github.com/Joker-388/JKRCustomSearchController/blob/master/preImage.gif)](http://www.jianshu.com/u/95d5ea0acd19)&nbsp;
<br><br>模仿微信自定义searchController

和UISearchController相同的使用方式，只需要设置searchBar为tableView的tableHeaderView就可以：
```
[self.tableView setTableHeaderView:self.searchController.searchBar];
```
控制器懒加载：
```
- (JKRSearchController *)searchController {
    if (!_searchController) {
        JKRSearchResultViewController *resultSearchController = [[JKRSearchResultViewController alloc] init];
        _searchController = [[JKRSearchController alloc] initWithSearchResultsController:resultSearchController];
        _searchController.searchBar.placeholder = @"搜索";
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.delegate = self;
        _searchController.delegate = self;
    }
    return _searchController;
}
```
搜索结果展示：
```
#pragma mark - JKRSearchControllerhResultsUpdating
- (void)updateSearchResultsForSearchController:(JKRSearchController *)searchController {
    NSString *searchText = searchController.searchBar.text;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)", searchText];
    JKRSearchResultViewController *resultController = (JKRSearchResultViewController *)searchController.searchResultsController;
    if (!(searchText.length > 0)) resultController.filterDataArray = @[];
    else resultController.filterDataArray = [self.dataArray filteredArrayUsingPredicate:predicate];
}
```
