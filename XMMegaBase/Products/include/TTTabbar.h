//
//  TTTabbar.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TTTabbarItem.h"

@protocol TTTabbarDelegate;

@interface TTTabbar : UIView <TTTabbarItemDelegate>

/**
 *  当前选中 item 的索引
 */
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;

/**
 *  tabbardelegate
 */
@property (nonatomic, weak) id<TTTabbarDelegate> delegate;

/**
 *  创建 tabbar
 *
 *  @param frame    frame
 *  @param items    items 数组
 *  @param delegate delegate
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<TTTabbarDelegate>)delegate;

/**
 *  设置背景
 *
 *  @param backgroundImage 背景图
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage;


/**
 *  选中某个 item
 *
 *  @param index 索引
 */
- (void)selectItemAtIndex:(NSInteger)index;


@end

@protocol TTTabbarDelegate <NSObject>

@optional

/**
 *  选中了某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 */
- (void)tabBar:(TTTabbar *)tabBar didSelectItemAtIndex:(NSUInteger)index;

/**
 *  是否能选中某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 *
 *  @return
 */
- (BOOL)tabBar:(TTTabbar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index;


@end