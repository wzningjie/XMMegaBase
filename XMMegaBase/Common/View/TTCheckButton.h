//
//  TTCheckButton.h
//  HongBao
//
//  Created by Ivan on 16/2/18.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface TTCheckButton : UIButton

/**
 *  创建TTCheckButton,从main bundle中取图
 *
 *  @param frame      button frame
 *  @param imageNames 图片数组
 *
 *  @return TTCheckButton
 */

- (instancetype) initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames;



/**
 *  创建TTCheckButton,通用图片加载方式；如果要使用内置图片，可简单使用init.
 *
 *  @param frame      button frame
 *  @param imageNames 图片数组
 *  @param moduleName 图片所在模块.moduleName为nil时，图片加载自main bundle.
 *
 *  @return TTCheckButton
 */
- (instancetype) initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames inModule:(NSString*)moduleName;

@end
