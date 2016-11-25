//
//  BaseWallViewController.h
//  HongBao
//
//  Created by Ivan on 16/1/24.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseCollectionViewController.h"

#import "WallViewLayout.h"
#import "DefaultWallCell.h"
#import "DefaultWallHeaderCell.h"

@interface BaseWallViewController : BaseCollectionViewController <WallViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) BOOL hasHeader;

@end
