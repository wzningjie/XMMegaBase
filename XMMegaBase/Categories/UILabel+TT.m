//
//  UILabel+TT.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "UILabel+TT.h"

@implementation UILabel (TT)

+ (UILabel *)labelWithText:(NSString *)text color:(UIColor *)color align:(NSTextAlignment)align font:(UIFont *)font background:(UIColor *)background frame:(CGRect)frame {
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (!background) {
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.backgroundColor = background;
    }
    label.text = text;
    label.textAlignment = align;
    label.textColor = color;
    label.font = font;
    return label;
}
@end
