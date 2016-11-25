//
//  UIImageView+TT.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "UIImageView+WebCache.h"

/**
 *  UIImageView 扩展
 */
@interface UIImageView (TT)

/**
 *  设置网络图片
 *
 *  @param url 图片地址
 */
- (void)setOnlineImage:(NSString*)url;

/**
 *  设置网络图片
 *
 *  @param url              图片地址
 *  @param placeHolderImage 占位的默认图
 */
- (void)setOnlineImage:(NSString*)url placeHolderImage:(UIImage *)placeHolderImage;

/**
 *  设置网络图片
 *
 *  @param url              图片地址
 *  @param placeHolderImage 占位图
 *  @param animated         是否显示动画
 */
- (void)setOnlineImage:(NSString*)url placeHolderImage:(UIImage *)placeHolderImage animated:(BOOL)animated;

/**
 *  设置网络图片
 *
 *  @param url              图片地址
 *  @param completedBlock   图片下载完成后的操作
 */
- (void)setOnlineImage:(NSString *)url complete:(void (^)(UIImage *image))completedBlock;

/**
 *  设置网络图片
 *
 *  @param url              图片地址
 *  @param placeHolderImage 占位图
 *  @param completedBlock   图片下载完成后的操作
 */
- (void)setOnlineImage:(NSString *)url placeHolderImage:(UIImage *)placeHolderImage complete:(void (^)(UIImage *image))completedBlock;

@end
