//
//  TTTabbarController.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTTabbarController.h"
#import "UIView+TT.h"
#import "UIMacro.h"
#import "ColorMarco.h"

@interface TTTabbarController ()

@property (nonatomic, assign) BOOL isShowTuanGou;//是否显示团购
@property (nonatomic, strong) NSArray    *viewControllers;
@property (nonatomic, strong) NSArray *defaultViewControllers;
@property (nonatomic, strong) TTTabbar  *tabBar;
@property (nonatomic, strong) BaseViewController *selectedViewController;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation TTTabbarController

- (id)initWithViewControllers:(NSArray *)viewControllers
{
    self = [super init];
    if (self) {
        self.viewControllers = viewControllers;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameWillChange:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    
}

- (void)reloadData{
    
    NSMutableArray *itemsArray = [NSMutableArray array];
    
    for (BaseViewController *viewController in self.viewControllers) {
        viewController.defaultFrame = CGRectMake(0, 0, self.view.width, self.view.height - TABBAR_HEIGHT);
        
        TTTabbarItem *tabBarItem = viewController.tabbarItem;
        if (!tabBarItem) {
            tabBarItem = [[TTTabbarItem alloc] initWithTitle:viewController.title titleColor:Color_Gray51 selectedTitleColor:nil icon:nil selectedIcon:nil];
            viewController.tabbarItem = tabBarItem;
        }
        [itemsArray addObject:tabBarItem];
        [self addChildViewController:viewController];
        viewController.tabBarController = self;
    }
    
    self.selectIndex = 0;
    self.selectedViewController = self.viewControllers[0];
    [self.view addSubview:[self.viewControllers[self.selectIndex] view]];
    
    self.tabBar = [[TTTabbar alloc] initWithFrame:CGRectMake(0, self.view.height - TABBAR_HEIGHT, self.view.width, TABBAR_HEIGHT) items:itemsArray delegate:self];
    [self.view addSubview:self.tabBar];
    
}

- (void)statusBarFrameWillChange:(NSNotification*)notification
{
    _tabBar.top = SCREEN_HEIGHT - TABBAR_HEIGHT - [[UIApplication sharedApplication] statusBarFrame].size.height + 20;
}

//- (void)statusBarFrameDidChange:(NSNotification*)notification
//{
//    DBG(@"%@", notification);
//}

- (void)selectAtIndex:(NSInteger)index
{
    if (index > _viewControllers.count - 1) {
        return;
    }

    BaseViewController *vc = _viewControllers[index];
    
    NSInteger newIndex = 0;
    for (int i= 0; i < self.viewControllers.count; i++) {
        if ([vc isKindOfClass:[self.viewControllers[i] class]]) {
            newIndex = i;
        }
    }
    [self.tabBar selectItemAtIndex:newIndex];
    
}

#pragma mark tabbar delegate
- (void)tabBar:(TTTabbar *)tabBar didSelectItemAtIndex:(NSUInteger)index
{
    if (self.selectIndex == index) {
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarControllerWhenAppeared)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarControllerWhenAppeared) withObject:nil];
        }
    }
    else
    {
        [self.selectedViewController.view removeFromSuperview];
        
        self.selectIndex = index;
        self.selectedViewController = self.viewControllers[self.selectIndex];
        
        [self.view insertSubview:self.selectedViewController.view belowSubview:self.tabBar];
        
        if ([self.tabBarControllerDelegate respondsToSelector:@selector(tabBarController:didSelectViewController:atIndex:)]) {
            
            [self.tabBarControllerDelegate tabBarController:self didSelectViewController:self.selectedViewController atIndex:self.selectIndex];
        }
        
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarController)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarController) withObject:nil];
        }
    }
}

- (BOOL)tabBar:(TTTabbar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index
{
    BOOL shouldSelect = YES;
    if ([self.tabBarControllerDelegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:atIndex:)]) {
        shouldSelect = [self.tabBarControllerDelegate tabBarController:self shouldSelectViewController:self.viewControllers[index] atIndex:index];
    }
    
    return shouldSelect;
}

//懒加载
//- (NSArray *)viewControllers
//{
//    if (_isShowTuanGou) {
//        return _viewControllers;
//    } else {
//        return _defaultViewControllers;
//    }
//}
//
//- (void)isNeedShowTuanGou:(NSNotification *)notification{
//    
//    _isShowTuanGou = YES;
//    [self reloadData];
//    
//}

@end
