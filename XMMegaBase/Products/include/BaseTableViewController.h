//
//  BaseTableViewController.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "RootScrollViewController.h"
#import "SVPullToRefresh.h"
#import "DefaultRefreshView.h"

@interface BaseTableViewController : RootScrollViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

- (void)addTableView;

- (void)showNoMoreDataNotice:(NSString *)text;

- (void)hideNoMoreDataNotice;

- (void)reloadData;

@end
