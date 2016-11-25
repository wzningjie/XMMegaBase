//
//  TTActivityIndicatorView.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface TTActivityIndicatorView : UIView

/**
 *  在指定的 view 中显示 loading
 *
 *  @param view     需要加 loading 的 view
 *  @param animated 是否需要动画
 *
 *  @return
 */
+ (TTActivityIndicatorView *)showInView:(UIView *)view animated:(BOOL)animated;

/**
 *  隐藏指定 view 中的 loading
 *
 *  @param view     需要移除 loading 的 view
 *  @param animated 是否需要动画
 *
 *  @return 
 */
+ (BOOL)hideActivityIndicatorForView:(UIView *)view animated:(BOOL)animated;
@end
