//
//  TTGalleryViewController.h
//  HongBao
//
//  Created by Ivan on 16/3/16.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "BaseViewController.h"

@interface TTGalleryViewController : BaseViewController

// 图片来自网络
@property (nonatomic, strong) NSArray *images;

// 图片来自内存
@property (nonatomic, strong) NSArray<UIImage*> *imageDatas;

@property (nonatomic, assign) NSInteger index;

@end
