//
//  WallItemCell.m
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "WallItemCell.h"
#import "WallItemModel.h"
#import "UIImageView+TT.h"
#import "UIView+TT.h"
#import "ColorMarco.h"
#import "ShortcutMacro.h"

@interface WallItemCell ()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *priceLable;

@end

@implementation WallItemCell

- (void)reloadData
{
    
    if (self.cellData) {
        
        WallItemModel *wallItem = (WallItemModel *)self.cellData;
        
        [self cellAddSubview:self.itemImageView];
        [self cellAddSubview:self.titleLable];
        [self cellAddSubview:self.priceLable];
        
        
        self.itemImageView.height = wallItem.image.h / wallItem.image.w * CELL_WIDTH;
        [self.itemImageView setOnlineImage:wallItem.image.src];
        
        self.titleLable.text = wallItem.title;
        [self.titleLable sizeToFit];
        self.titleLable.width = CELL_WIDTH;
        self.titleLable.top = self.itemImageView.bottom + 4;
        
        self.priceLable.text = wallItem.price;
        [self.priceLable sizeToFit];
        self.priceLable.width = CELL_WIDTH;
        self.priceLable.top = self.titleLable.bottom + 2;
        self.backgroundColor = Color_White;
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        
        WallItemModel *wallItem = (WallItemModel *)cellData;
        
        CGFloat height = wallItem.image.h / wallItem.image.w * CELL_WIDTH;
        
        height += 40;
        
        return height;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)itemImageView {
    
    if ( !_itemImageView ) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, CELL_WIDTH, 0)];
    }
    
    return _itemImageView;
}

- (UILabel *)titleLable {
    
    if ( !_titleLable ) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLable.textColor = Color_Gray100;
        _titleLable.font = FONT(12);
    }
    
    return _titleLable;
    
}

- (UILabel *)priceLable {
    
    if ( !_priceLable ) {
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _priceLable.textColor = Color_Gray66;
        _priceLable.font = FONT(14);
    }
    
    return _priceLable;
    
}

@end
