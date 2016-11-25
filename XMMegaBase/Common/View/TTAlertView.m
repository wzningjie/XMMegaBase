//
//  TTAlertView.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//


#import "TTAlertView.h"
#import "Macros.h"
#import "Categories.h"
#import "UIImage+TT.h"

#define MARGIN              10.f
#define ALERT_WIDTH         260.f

@implementation TTAlertView

- (id)initWithTitle:(NSString *)title message:(NSString *)message containerView:(UIView *)containerView delegate:(id <TTAlertViewDelegate>)delegate confirmButtonTitle:(NSString *)confirmButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles
{
    self = [super init];
    if (self) {
        
        self.delegate = delegate;
        self.opaque = NO;

        // 初始化window
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.windowLevel = UIWindowLevelStatusBar + 1;
        self.window.opaque = NO;
        
        // 遮罩
        self.overlayView = [[UIView alloc] initWithFrame:self.window.bounds];
        self.overlayView.backgroundColor = [UIColor blackColor];
        self.overlayView.opaque = NO;
        [self.window addSubview:self.overlayView];
        
        // 具体内容
        CGFloat totalHeight = 20.f;
        
        // 标题
        if (title) {
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 2, totalHeight, ALERT_WIDTH - MARGIN * 4, 20)];
            self.titleLabel.font = BOLD_FONT(17);
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.text = title;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.numberOfLines = 0;
            self.titleLabel.textColor = Color_Gray58;
            [self addSubview:self.titleLabel];
            
            //标题的高度可变
            CGSize titleSize = [title sizeWithUIFont:BOLD_FONT(17) forWidth:self.titleLabel.width];
            self.titleLabel.height = titleSize.height;
            
            totalHeight += self.titleLabel.bounds.size.height;
        }
        
        // 内容
        if (message) {
//            message = [message replaceLineSymbol];
//            totalHeight += MARGIN;
            self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN * 2, totalHeight, ALERT_WIDTH - MARGIN * 4, 0)];
            self.messageLabel.numberOfLines = 0;
            self.messageLabel.text = message;
//            self.messageLabel.textColor = RGB(102, 102, 102);
            self.messageLabel.textColor = [UIColor blackColor];
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.font = FONT(15);
            
            CGSize size = [message sizeWithUIFont:FONT(15) forWidth:self.messageLabel.width];
            self.messageLabel.frame = (CGRect) {self.messageLabel.frame.origin, self.messageLabel.width, size.height};
            
            [self addSubview:self.messageLabel];
            totalHeight += self.messageLabel.height;
        }
        
        if (containerView) {
            
            totalHeight += 14.f;
            self.containerView = containerView;
            self.containerView.top = totalHeight;
            self.containerView.centerX = ALERT_WIDTH/2.f;
            totalHeight += self.containerView.height;

            [self addSubview:self.containerView];
        }
        
        //先算出当前的按钮个数
        int numberOfButton = 0;
        if (!IsEmptyString(confirmButtonTitle)) {
            numberOfButton = 1;
        }
        numberOfButton += otherButtonTitles.count;
        
        //根据不同的按钮个数 给出不同的样式
        if (numberOfButton > 0) {
            
            if(self.containerView){
                totalHeight += 14.f;
            }
            else {
                totalHeight += 20.f;
            }
            
            if (numberOfButton == 2) {
                
                UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0, totalHeight, ALERT_WIDTH, 1/[[UIScreen mainScreen] scale])];
                contentBtnSegementLine.backgroundColor = Color_Gray230;
                [self addSubview:contentBtnSegementLine];

                UIView *btnSegmentLine = [[UIView alloc] initWithFrame:CGRectMake(ALERT_WIDTH / 2, totalHeight, 1/[[UIScreen mainScreen] scale], 45.f)];
                btnSegmentLine.backgroundColor = Color_Gray230;
                [self addSubview:btnSegmentLine];
                
                if (!IsEmptyString(confirmButtonTitle)) {
                    
                    NSString *otherButtonTitle = [otherButtonTitles firstObject];
                    UIButton *anotherButton = [UIButton buttonWithTitle:otherButtonTitle frame:CGRectMake(0, totalHeight, ALERT_WIDTH / 2, 45.f) target:self action:@selector(buttonDidtouched:) forControlEvents:UIControlEventTouchUpInside];
                    anotherButton.tag = 1;
                    anotherButton.titleLabel.font = FONT(16);
                    [anotherButton setTitleColor:Color_Gray100 forState:UIControlStateNormal];
                    [self addSubview:anotherButton];
                    
                    UIButton *confirmButton = [UIButton buttonWithTitle:confirmButtonTitle frame:CGRectMake(anotherButton.right, totalHeight, ALERT_WIDTH / 2, 45.f) target:self action:@selector(buttonDidtouched:) forControlEvents:UIControlEventTouchUpInside];
                    confirmButton.tag = 0;
                    confirmButton.titleLabel.font = FONT(16);
                    [confirmButton setTitleColor:Color_Red forState:UIControlStateNormal];
                    [self addSubview:confirmButton];
                    
                }
                else {
                    
                    for (int i = 0; i < [otherButtonTitles count]; i++) {
                        
                        NSString *otherButtonTitle = [otherButtonTitles objectAtIndex:i];
                        UIButton *anotherButton = [UIButton buttonWithTitle:otherButtonTitle frame:CGRectMake(0, totalHeight, ALERT_WIDTH / 2, 45.f) target:self action:@selector(buttonDidtouched:) forControlEvents:UIControlEventTouchUpInside];
                        anotherButton.left = ALERT_WIDTH / 2 * i;
                        anotherButton.titleLabel.font = FONT(16);
                        [anotherButton setTitleColor:Color_Gray100 forState:UIControlStateNormal];
                        [self addSubview:anotherButton];
                        anotherButton.tag = i+1;
                        
                    }
                    
                }
                totalHeight += 45.f;
                
            }else {
                
                if (!IsEmptyString(confirmButtonTitle)) {
                 
                    UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0, totalHeight, ALERT_WIDTH, 1/[[UIScreen mainScreen] scale])];
                    contentBtnSegementLine.backgroundColor = RGB(228, 228, 228);
                    [self addSubview:contentBtnSegementLine];

                    UIButton *confirmButton = [UIButton buttonWithTitle:confirmButtonTitle frame:CGRectMake(0, totalHeight, ALERT_WIDTH, 45.f) target:self action:@selector(buttonDidtouched:) forControlEvents:UIControlEventTouchUpInside];
                    confirmButton.tag = 1;
                    confirmButton.titleLabel.font = FONT(16);
                    [confirmButton setTitleColor:Color_Red forState:UIControlStateNormal];
                    [self addSubview:confirmButton];
                    
                    totalHeight += 45.f;
                }
            
                for (int i = 0; i < [otherButtonTitles count]; i++) {
                    
                    UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0, totalHeight, ALERT_WIDTH, 1/[[UIScreen mainScreen] scale])];
                    contentBtnSegementLine.backgroundColor = RGB(228, 228, 228);
                    [self addSubview:contentBtnSegementLine];

                    NSString *otherButtonTitle = [otherButtonTitles objectAtIndex:i];
                    UIButton *anotherButton = [UIButton buttonWithTitle:otherButtonTitle frame:CGRectMake(0, totalHeight, ALERT_WIDTH, 45.f) target:self action:@selector(buttonDidtouched:) forControlEvents:UIControlEventTouchUpInside];
                    anotherButton.titleLabel.font = FONT(16);
                    [anotherButton setTitleColor:Color_Gray100 forState:UIControlStateNormal];
                    [self addSubview:anotherButton];
                    anotherButton.tag = i+1;
                    
                    totalHeight += 45.f;

                }

            }
//            totalHeight += 5.f;

        }
        else {
            
            totalHeight += 25.f;
            
        }

        self.frame = CGRectIntegral(CGRectMake((self.window.bounds.size.width - ALERT_WIDTH) / 2, (self.window.bounds.size.height - totalHeight) / 2, ALERT_WIDTH, totalHeight));

        UIImageView *backgroudImage = [[UIImageView alloc] initWithFrame:self.bounds];
        
        backgroudImage.image = [[UIImage imageNamed:@"alert_bg" module:ModuleName] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 12, 22, 12)];
        [self insertSubview:backgroudImage atIndex:0];
        [self.window addSubview:self];    
        
    }
    return self;
}


- (void)show
{
    if (!self.window) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.windowLevel = UIWindowLevelStatusBar + 1;
        self.window.opaque = NO;
        [self.window addSubview:self];
    }
    
    self.overlayView.alpha = 0.f;
    [self.window makeKeyAndVisible];
    
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.overlayView.alpha = 0.3f;
    } completion:^(BOOL finished) {
        // stub
    }];
    
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.17 animations:^{
        self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.12 animations:^{
            self.layer.transform = CATransform3DMakeScale(0.9, 0.9, 1.0);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.layer.transform = CATransform3DIdentity;
            } completion:^(BOOL finished) {}];
        }];
    }];
}


#pragma mark - action method
- (void)buttonDidtouched:(UIButton *)button
{
    // 点击
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:button.tag];
    }
    
    // 动画前
    if ([self.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [self.delegate alertView:self willDismissWithButtonIndex:button.tag];
    }

    
    // 隐藏遮罩
    [UIView animateWithDuration:0.15 animations:^{
        self.overlayView.alpha = 0.0f;
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        self.layer.transform = CATransform3DMakeScale(1.1, 1.1, 1.0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            self.layer.transform = CATransform3DIdentity;
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            self.window = nil;
            [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
            
            // 动画结束
            if ([self.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
                [self.delegate alertView:self didDismissWithButtonIndex:button.tag];
            }
        }];
        
    }];

    
}

@end
