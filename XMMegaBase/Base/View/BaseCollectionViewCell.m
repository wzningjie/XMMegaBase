//
//  BaseCollectionViewCell.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (void)reloadData
{
    
}

- (void)cellAddSubview:(UIView *)view {
    
    if (view && ![view superview] ) {
        [self addSubview:view];
    }
    
}

+ (CGFloat)heightForCell:(id)cellData
{
    return 0;
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass([self class]);
}

@end
