//
//  DefaultWallHeaderCell.m
//  HongBao
//
//  Created by Ivan on 16/1/24.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "DefaultWallHeaderCell.h"
#import "UIMacro.h"
#import "ColorMarco.h"
#import "UIView+TT.h"

@interface DefaultWallHeaderCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DefaultWallHeaderCell

- (void)reloadData
{
    self.backgroundColor = Color_Gray100;
    
    if ( ![self.label superview ]) {
        [self addSubview:self.label];
    }
    
    self.label.text = @"headerViewCell";
    self.label.textColor = Color_White;
    [self.label sizeToFit];
    
    self.label.width = SCREEN_WIDTH;
    self.label.top = ( [DefaultWallHeaderCell heightForCell:self.cellData] - self.label.height ) / 2;
}

- (UILabel *)label
{
    if ( !_label ) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    
    return _label;
}

+ (CGFloat)heightForCell:(id)cellData
{
    return [cellData floatValue];
}

@end
