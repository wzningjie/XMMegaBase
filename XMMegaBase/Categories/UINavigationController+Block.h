//
//  UINavigationController+Block.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

//static id weakObject(id object) {
//    __block typeof(object) weakSelf = object;
//    return weakSelf;
//}

#import <UIKit/UIKit.h>

static id weakObject(id object) {
    __typeof__(object) __weak  weakSelf = object;
    return weakSelf;
}

@protocol iOSBlocksProtocol <NSObject>

typedef void (^VoidBlock)();
//typedef void (^CompletionBlock)(BOOL completed);

@end

@interface UINavigationController (Block) <UINavigationControllerDelegate, iOSBlocksProtocol>

/**
 *  push一个新的ViewController
 *
 *  @param viewController 需要push的ViewController
 *  @param animated       是否要做进场动画
 *  @param completion     完成push之后的回调方法
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
              onCompletion:(VoidBlock)completion;

/**
 *  pop一个需要pop的ViewController
 *
 *  @param viewController 需要pop的ViewController
 *  @param animated       是否要做进场动画
 *  @param completion     完成pop后的回调方法
 */
- (void)popToViewController:(UIViewController *)viewController
                   animated:(BOOL)animated
               onCompletion:(VoidBlock)completion;

/**
 *  pop当前最顶部的ViewController
 *
 *  @param animated   是否要做进场动画
 *  @param completion 完成pop后的回调方法
 */
- (void)popViewControllerAnimated:(BOOL)animated
                     onCompletion:(VoidBlock)completion;

/**
 *  pop到第一层ViewController
 *
 *  @param animated   是否要做进场动画
 *  @param completion 完成pop后的回调方法
 */
- (void)popToRootViewControllerAnimated:(BOOL)animated
                           onCompletion:(VoidBlock)completion;

@end
