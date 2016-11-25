//
//  TTAmountView.h
//  HongBao
//
//  Created by Ivan on 16/2/12.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol TTAmountDelegate <NSObject>

- (void)increaseButtonDidTap;
- (void)decreaseButtonDidTap;

@end

@interface TTAmountView : UIControl

@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) NSInteger maxAmount;
@property (nonatomic, weak) id<TTAmountDelegate> delegate;

@end
