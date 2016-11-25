//
//  BaseCollectionViewController.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "RootScrollViewController.h"

#import "SVPullToRefresh.h"
#import "DefaultRefreshView.h"

@interface BaseCollectionViewController : RootScrollViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;

/**
 *  添加 CollectionView，若需要修改 CollectionView 的大小，请重写该方法，在调用父类 addCollectionView 后修改。
 */
- (void)addCollectionView;

- (void)reloadData;

@end
