//
//  WallModel.h
//  HongBao
//
//  Created by Ivan on 16/3/2.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseModel.h"
#import "WallItemModel.h"

@protocol WallModel

@end

@interface WallModel : BaseModel

@property (nonatomic, strong) NSArray<WallItemModel> *list;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, strong) NSString *wp;

@end
