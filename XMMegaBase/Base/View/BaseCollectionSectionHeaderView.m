//
//  BaseCollectionSectionHeaderView.m
//  HongBao
//
//  Created by Ivan on 16/3/3.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseCollectionSectionHeaderView.h"

@implementation BaseCollectionSectionHeaderView

- (void)reloadData
{
    
}

- (void)headerAddSubview:(UIView *)view {
    
    if (view && ![view superview] ) {
        [self addSubview:view];
    }
    
}

+ (CGFloat)heightForHeader:(id)cellData
{
    return 45;
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

@end
