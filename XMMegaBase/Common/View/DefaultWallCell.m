//
//  DefaultWallCell.m
//  HongBao
//
//  Created by Ivan on 16/1/24.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "DefaultWallCell.h"
#import "UIView+TT.h"
#import "ColorMarco.h"

@interface DefaultWallCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DefaultWallCell

- (void)reloadData
{
    self.backgroundColor = Color_Gray230;
    
    if ( ![self.label superview ]) {
        [self addSubview:self.label];
    }
    
    self.label.text = (NSString *)self.cellData;
    [self.label sizeToFit];
    
    self.label.width = CELL_WIDTH;
    self.label.top = ( [DefaultWallCell heightForCell:self.cellData] - self.label.height ) / 2;
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
    return 100 + 5 * [cellData intValue];
}

@end
