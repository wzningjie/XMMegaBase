//
//  BaseCollectionSectionHeaderView.h
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BaseCollectionSectionHeaderView : UICollectionReusableView

/**
 *  SectionHeader 的数据对象
 */
@property (nonatomic, strong) id cellData;

/**
 *  reloadData 方法，子类自己实现
 */
- (void)reloadData;

- (void)headerAddSubview:(UIView *)view;

/**
 *  返回当前 SectionHeader 的 identifier，默认为类名
 *
 *  @return 当前 SectionHeader 的 identifier
 */
+ (NSString *)identifier;

/**
 *  获得 SectionHeader 高度
 */
+ (CGFloat)heightForHeader:(id)cellData;

@end
