//
//  BaseTableViewController.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewCell.h"
#import "Macros.h"
#import "UIView+TT.h"
#import "UIButton+TT.h"
#import "UIView+BlocksKit.h"
#import "UIImage+TT.h"

@interface BaseTableViewController ()
@end

@implementation BaseTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addTableView];
    [self addRefreshAndLoadMore];
    [self customPullToRefreshView];
    [self customInfiniteScrollingView];
    [self addBackToTopButton];
    [self addNavigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.hideNavigationBar ? 0 : NAVBAR_HEIGHT, self.view.width, self.view.height - (self.hideNavigationBar ? 0 : NAVBAR_HEIGHT)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.tableView];
    [self.view sendSubviewToBack:self.tableView];
    
}

- (void)customPullToRefreshView{
    
    DefaultRefreshView *refreshView = [[DefaultRefreshView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, NAVBAR_HEIGHT)];
    refreshView.loadingType = kRefresh;
    
    [self.tableView.pullToRefreshView addRefreshView:refreshView];
}

- (void)customInfiniteScrollingView{
    
    DefaultRefreshView *loadingView = [[DefaultRefreshView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, NAVBAR_HEIGHT)];
    loadingView.loadingType = kLoadMore;
    
    [self.tableView.infiniteScrollingView addRefreshView:loadingView];
}

- (void)addBackToTopButton{
    
    self.backToTopButton = [UIButton buttonWithImage:[UIImage imageNamed:@"btn_to_top" module:ModuleName] highlightedImage:[UIImage imageNamed:@"btn_to_top" module:ModuleName] target:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    
    self.backToTopButton.frame = CGRectMake(self.view.width-72, self.tableView.bottom-44-10, 72,44);
    
    [self.view insertSubview:self.backToTopButton aboveSubview:self.tableView];
    
    self.backToTopButton.alpha = 0;
    self.isBackToTop = NO;
    //回到顶部
    
    __weak __typeof(self)weakSelf = self;
    
    [self.backToTopButton bk_whenTapped:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        [strongSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        strongSelf.isBackToTop = NO;
        strongSelf.backToTopButton.alpha = 0;
    }];
}

- (void)addRefreshAndLoadMore{
    
    weakify(self);
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        strongify(self);
        [self doRefresh];
    }];
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        strongify(self);
        [self doLoadMore];
    }];
}

- (void)reloadData{
    [self.tableView reloadData];
}

- (void)startRefresh{
    [self.tableView triggerPullToRefresh];
}

- (void)finishRefresh{
    [self.tableView.pullToRefreshView stopAnimating];
}

- (void)finishLoadMore{
    [self.tableView.infiniteScrollingView stopAnimating];
}

- (void)doRefresh
{
    [super doRefresh];
    self.loadingType = kRefresh;
    [self loadData];
}

- (void)doLoadMore
{
    [super doLoadMore];
    self.loadingType = kLoadMore;
    [self loadData];
}

- (void)showNoMoreDataNotice:(NSString *)text{
    
    if (!text) {
        text = @"没有更多了…";
    }
    UILabel *noMoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    noMoreLabel.text = text;
    noMoreLabel.font = FONT(13);
    noMoreLabel.textColor = Color_Gray100;
    noMoreLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.tableView setTableFooterView:noMoreLabel];
}

- (void)hideNoMoreDataNotice{
    [self.tableView setTableFooterView:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseTableViewCell *cell = [BaseTableViewCell dequeueReusableCellForTableView:tableView];
    [cell reloadData];
    return cell;
}

@end
