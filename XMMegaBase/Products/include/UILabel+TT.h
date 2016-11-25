//
//  UILabel+TT.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UILabel (TT)

/**
 *  创建一个 label
 *
 *  @param text       text
 *  @param color      文字颜色
 *  @param align      对齐方式
 *  @param font       字体
 *  @param background 背景色
 *  @param frame      frame
 *
 *  @return label
 */
+ (UILabel *)labelWithText:(NSString *)text color:(UIColor *)color align:(NSTextAlignment)align font:(UIFont *)font background:(UIColor *)background frame:(CGRect)frame;
@end
