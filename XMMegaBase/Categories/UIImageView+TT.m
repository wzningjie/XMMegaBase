//
//  UIImageView+TT.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "UIImageView+TT.h"

@implementation UIImageView (TT)

- (void)setOnlineImage:(NSString *)url
{
    [self setOnlineImage:url placeHolderImage:nil];
}

- (void)setOnlineImage:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage
{
    [self setOnlineImage:url placeHolderImage:placeHolderImage animated:NO];
}

- (void)setOnlineImage:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage animated:(BOOL)animated
{
    self.clipsToBounds = YES;
    __weak UIImageView *wself = self;
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolderImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image || error) {
            return ;
        }
        wself.contentMode = UIViewContentModeScaleAspectFill;
        
        if (animated && !placeHolderImage) {
            wself.alpha = 0;
            [UIView animateWithDuration:0.7f animations:^{
                wself.alpha = 1.f;
            }];
        }
    }];
}

- (void)setOnlineImage:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage complete:(void (^)(UIImage *image))completedBlock
{
    self.clipsToBounds = YES;
    __weak UIImageView *weakSelf = self;
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeHolderImage options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image || error) {
            return ;
        }
        
        weakSelf.contentMode = UIViewContentModeScaleAspectFill;
        
        if (completedBlock) {
            completedBlock(image);
        }
        
    }];
}

- (void)setOnlineImage:(NSString *)url complete:(void (^)(UIImage *image))completedBlock {
    [self setOnlineImage:url placeHolderImage:nil complete:completedBlock];
}

@end
