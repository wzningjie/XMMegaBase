//
//  BaseCollectionViewCell.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMacro.h"

#define CELL_PADDING 15.f
#define CELL_WIDTH ((SCREEN_WIDTH - CELL_PADDING) / 2)

@interface BaseCollectionViewCell : UICollectionViewCell

/**
 *  cell 的数据对象
 */
@property (nonatomic, strong) id cellData;

/**
 *  reloadData 方法，子类自己实现
 */
- (void)reloadData;

- (void)cellAddSubview:(UIView *)view;

/**
 *  返回当前 cell 的 identifier，默认为类名
 *
 *  @return 当前 cell 的 identifier
 */
+ (NSString *)cellIdentifier;

/**
 *  获得cell高度
 */
+ (CGFloat)heightForCell:(id)cellData;

@end
