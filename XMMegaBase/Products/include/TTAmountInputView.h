//
//  TTAmountView.h
//  HongBao
//
//  Created by Ivan on 16/2/12.
//  Copyright © 2016年 ivan. All rights reserved.
//


@class TTAmountInputView;
@protocol TTAmountInputDelegate <NSObject>

@optional

//textfield only
- (void)amountInputViewDidBeginEditing:(TTAmountInputView*)inputView;
- (void)amountInputViewDidChangeValue:(TTAmountInputView*)inputView;
- (void)amountInputViewDidEndEditing:(TTAmountInputView*)inputView;

//button only
- (void)amountInputViewDidIncrease:(TTAmountInputView *)inputView;
- (void)amountInputViewDidDecrease:(TTAmountInputView *)inputView;


@end

@interface TTAmountInputView : UIControl

@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, assign) NSInteger maxAmount;
@property (nonatomic, assign) NSInteger minAmount;
@property (nonatomic, weak) id<TTAmountInputDelegate> delegate;
@property (nonatomic, assign) BOOL autoCorrection;
@end
