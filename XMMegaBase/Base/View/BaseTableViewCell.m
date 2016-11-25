//
//  BaseTableViewCell.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        
        [self drawCell];
    
    }
    return self;
}

- (void)drawCell{

}
    
- (void)cellAddSubView:(UIView*)view
{
    [self.contentView addSubview:view];
}


- (void)reloadData{
    
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

+ (instancetype)dequeueReusableCellForTableView:(UITableView *)tableView
{
    id cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier]];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIdentifier]];
    }
    return cell;
}

+ (CGFloat)heightForCell:(id)cellData
{
    return 0;
}

@end
