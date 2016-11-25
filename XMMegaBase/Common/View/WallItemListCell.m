//
//  WaterItemSmallCell.m
//  HongBao
//
//  Created by marco on 5/10/16.
//  Copyright © 2016 ivan. All rights reserved.
//

#import "WallItemListCell.h"
#import "WallItemModel.h"
#import "UIImageView+TT.h"
#import "UIView+TT.h"
#import "ShortcutMacro.h"
#import "ColorMarco.h"

@interface WallItemListCell ()

@property (nonatomic, strong) UIImageView *itemImageView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *descLable;
@property (nonatomic, strong) UILabel *priceLable;
@property (nonatomic, strong) UIView *line;
@end

@implementation WallItemListCell

- (void)reloadData
{
    
    if (self.cellData) {
        
        WallItemModel *wallItem = (WallItemModel *)self.cellData;
        
        [self cellAddSubview:self.itemImageView];
        [self cellAddSubview:self.titleLable];
        [self cellAddSubview:self.descLable];
        [self cellAddSubview:self.priceLable];
        [self cellAddSubview:self.line];
        
        self.itemImageView.height = IMAGE_WIDTH;
        [self.itemImageView setOnlineImage:wallItem.image.src];
        
        self.titleLable.text = wallItem.title;
        CGSize textSize = [wallItem.title boundingRectWithSize:CGSizeMake( DESC_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: FONT(14)} context:nil].size;
        self.titleLable.height = textSize.height;
        self.titleLable.width = DESC_WIDTH;
        self.titleLable.top = 10;
        self.titleLable.left = self.itemImageView.right + CELL_PADDING;
        
        self.descLable.text = wallItem.extraDesc;
        [self.descLable sizeToFit];
        self.descLable.width = DESC_WIDTH;
        self.descLable.centerY = IMAGE_WIDTH/2;
        self.descLable.left = self.itemImageView.right + CELL_PADDING;
        
        self.priceLable.text = wallItem.price;
        [self.priceLable sizeToFit];
        self.priceLable.width = DESC_WIDTH;
        self.priceLable.bottom = self.itemImageView.height - 10;
        self.priceLable.left = self.itemImageView.right + CELL_PADDING;
        
    }
}

+ (CGFloat)heightForCell:(id)cellData
{
    if (cellData) {
        
        //WallItemModel *wallItem = (WallItemModel *)cellData;
        
        CGFloat height = IMAGE_WIDTH+LINE_WIDTH;
        
        return height;
    }
    
    return 0;
}

#pragma mark - Getters And Setters

- (UIImageView *)itemImageView {
    
    if ( !_itemImageView ) {
        _itemImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 0, 0, IMAGE_WIDTH, IMAGE_WIDTH)];
    }
    
    return _itemImageView;
}

- (UILabel *)titleLable {
    
    if ( !_titleLable ) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _titleLable.numberOfLines = 2;
        _titleLable.lineBreakMode = NSLineBreakByCharWrapping;
        _titleLable.textColor = Color_Gray100;
        _titleLable.font = FONT(14);
    }
    
    return _titleLable;
    
}

- (UILabel *)priceLable {
    
    if ( !_priceLable ) {
        _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _priceLable.textColor = Color_Red6;
        _priceLable.font = FONT(16);
    }
    
    return _priceLable;
    
}

- (UILabel*)descLable
{
    if (!_descLable) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        label.font = FONT(14);
        label.textColor = Color_Gray100;
        _descLable = label;
    }
    return _descLable;
}

- (UIView *)line
{
    if (!_line) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(IMAGE_WIDTH + CELL_PADDING, IMAGE_WIDTH, SCREEN_WIDTH - CELL_PADDING - IMAGE_WIDTH, LINE_WIDTH)];
        view.backgroundColor = Color_Gray170;
        _line = view;
    }
    return _line;
}

@end

