//
//  WallViewLayout.h
//  HongBao
//
//  Created by Ivan on 16/1/24.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WallViewLayout;

@protocol WallViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@required

- (NSInteger)collectionView:(UICollectionView *)collectionView
                     layout:(WallViewLayout *)layout
   numberOfColumnsInSection:(NSInteger)section;

@end

//@protocol WallViewDataSource <UICollectionViewDataSource>
//
//@optional
//
//- (CGFloat)headerHeightForCollectionView:(UICollectionView *)collectionView;
//
//- (UIView *)headerViewForWallView:(UICollectionView *)collectionView;
//
//@end

@interface WallViewLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WallViewDelegateFlowLayout> delegate;
//@property (nonatomic, weak) id<WallViewDataSource> dataSource;

@end
