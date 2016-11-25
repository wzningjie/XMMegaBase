//
//  WallItemModel.h
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "ImageUnitModel.h"

@protocol WallItemModel

@end

@interface WallItemModel : BaseModel

@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) ImageUnitModel *image;
@property (nonatomic, strong) NSString<Optional> *extraDesc;
@end
