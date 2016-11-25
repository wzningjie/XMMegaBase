//
//  BaseCollectionViewController.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "BaseCollectionViewCell.h"
#import "UIView+BlocksKit.h"
#import "UIView+TT.h"
#import "UIButton+TT.h"
#import "UIImage+TT.h"
#import "ColorMarco.h"
#import "UIMacro.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addCollectionView];
    [self addNavigationBar];
    [self addRefreshAndLoadMore];
    [self customInfiniteScrollingView];
    [self customPullToRefreshView];
    [self addBackToTopButton];
    
}

#pragma mark - Custom Methods

- (void)addCollectionView
{
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.hideNavigationBar ? 0 : NAVBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - (self.hideNavigationBar ? 0 : NAVBAR_HEIGHT)) collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self registCell];
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - Private Methods

- (void)reloadData{
    [self.collectionView reloadData];
}

- (void)registCell
{
    [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BaseCollectionViewCell class])];
}

- (void)customPullToRefreshView{
    
    DefaultRefreshView *refreshView = [[DefaultRefreshView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, NAVBAR_HEIGHT)];
    refreshView.loadingType = kRefresh;
    
    [self.collectionView.pullToRefreshView addRefreshView:refreshView];
}

- (void)customInfiniteScrollingView{
    
    DefaultRefreshView *loadingView = [[DefaultRefreshView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, NAVBAR_HEIGHT)];
    loadingView.loadingType = kLoadMore;
    
    [self.collectionView.infiniteScrollingView addRefreshView:loadingView];
}

- (void)addBackToTopButton{
    
    self.backToTopButton = [UIButton buttonWithImage:[UIImage imageNamed:@"btn_to_top" module:ModuleName] highlightedImage:[UIImage imageNamed:@"btn_to_top" module:ModuleName] target:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    
    self.backToTopButton.frame = CGRectMake(self.view.width-72, self.collectionView.bottom - 44 - 10, 72, 44);
    
    [self.view insertSubview:self.backToTopButton aboveSubview:self.collectionView];
    
    self.backToTopButton.alpha = 0;
    self.isBackToTop = NO;
    //回到顶部
    
    weakify(self);
    [self.backToTopButton bk_whenTapped:^{
        
        strongify(self);
        
        [self.collectionView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.isBackToTop = NO;
        self.backToTopButton.alpha = 0;
    }];
}

- (void)addRefreshAndLoadMore{
    
    weakify(self);
    
    // setup pull-to-refresh
    [self.collectionView addPullToRefreshWithActionHandler:^{
        strongify(self);
        [self doRefresh];
    }];
    
    // setup infinite scrolling
    [self.collectionView addInfiniteScrollingWithActionHandler:^{
        strongify(self);
        [self doLoadMore];
    }];
}

- (void)startRefresh{
    [self.collectionView triggerPullToRefresh];
}

- (void)finishRefresh{
    [self.collectionView.pullToRefreshView stopAnimating];
}

- (void)finishLoadMore{
    [self.collectionView.infiniteScrollingView stopAnimating];
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


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BaseCollectionViewCell class]) forIndexPath:indexPath];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
