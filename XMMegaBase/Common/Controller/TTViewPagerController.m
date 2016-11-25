//
//  TTViewPagerController.m
//  HongBao
//
//  Created by Ivan on 16/3/6.
//  Copyright © 2016年 ivan. All rights reserved.
//


#import "TTViewPagerController.h"
#import "TTTabbarController.h"
#import "UIMacro.h"
#import "NSMutableArray+NullCheck.h"
#import "ColorMarco.h"
#import "UIView+TT.h"
#import "ShortcutMacro.h"

#define kTabsView      101

@interface TTViewPagerController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

// Tab and content stuff
@property UIScrollView *tabsView;
@property UIView *singleTabsView;
@property UIView *contentView;

@property UIView *selectedBorder;
@property UIImageView *shadowLineLeft;
@property UIView *firstSelectedBorder;

@property (getter = isAnimatingToTab, assign) BOOL animatingToTab;

@property UIPageViewController *pageViewController;
@property (assign) id<UIScrollViewDelegate> actualDelegate;

// Tab and content cache
@property NSMutableArray *tabs;
@property NSMutableArray *contents;

@property NSMutableArray *titles;

@property (nonatomic) NSUInteger tabCount;
@property (nonatomic) NSUInteger activeTabIndex;
@property (nonatomic) NSUInteger activeContentIndex;

// Colors
@property (nonatomic) UIColor *tabsViewBackgroundColor;
@property (nonatomic) UIColor *contentViewBackgroundColor;

@property (nonatomic, strong) UIView *bottomLine;

@property (nonatomic, assign) BOOL isChoosing;

@property (nonatomic, strong) UIView *bgView;


@end

@implementation TTViewPagerController

#pragma mark - Init
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaultSettings];
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self defaultSettings];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    
    // Re-layout sub views
    [self layoutSubviews];
}

- (void)layoutSubviews {
    
    CGFloat topLayoutGuide = self.hideNavigationBar ? STATUSBAR_HEIGHT : NAVBAR_HEIGHT;
    
    CGRect frame = self.tabsView.frame;
    frame.origin.x = 0.0;
    frame.origin.y = topLayoutGuide;
    frame.size.width = CGRectGetWidth(self.view.frame);
    frame.size.height = TabsViewHeight;
    self.tabsView.frame = frame;
    
    frame = self.contentView.frame;
    frame.origin.x = 0.0;
    frame.origin.y = topLayoutGuide + CGRectGetHeight(self.tabsView.frame);
    if (self.noScroll) {
        frame.origin.y = topLayoutGuide + CGRectGetHeight(self.singleTabsView.frame);
    }
    frame.size.width = CGRectGetWidth(self.view.frame);
    frame.size.height = SCREEN_HEIGHT - TabsViewHeight - NAVBAR_HEIGHT - (self.tabBarController.tabBar.hidden ? 0 : CGRectGetHeight(self.tabBarController.tabBar.frame));
    self.contentView.frame = frame;
}

#pragma mark - Interface rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    // Re-layout sub views
    [self layoutSubviews];
    
    // Re-align tabs if needed
    self.activeTabIndex = self.activeTabIndex;
}

- (void)reloadData
{
    [self defaultSetup];
}

- (void) reloadContents
{
    [self.contents removeAllObjects];
    
    self.contents = [NSMutableArray arrayWithCapacity:self.tabCount];
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        [self.contents addObject:[NSNull null]];
    }
    
    [self selectTabAtIndex:0 noSwipe:NO];
    
}

- (void)defaultSettings {
    
    // pageViewController
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    [self addChildViewController:self.pageViewController];
    
    // Setup some forwarding events to hijack the scrollView
    // Keep a reference to the actual delegate
    self.actualDelegate = ((UIScrollView *)[self.pageViewController.view.subviews objectAtIndex:0]).delegate;
    // Set self as new delegate
    ((UIScrollView *)[self.pageViewController.view.subviews objectAtIndex:0]).delegate = self;
    
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    self.animatingToTab = NO;
}

- (void)defaultSetup
{
    // Empty tabs and contents
    for (UIView *tabView in self.tabs) {
        [tabView removeFromSuperview];
    }
    self.tabsView.contentSize = CGSizeZero;
    [self.tabsView removeAllSubviews];
    [self.singleTabsView removeAllSubviews];
    
    [self.tabs removeAllObjects];
    [self.contents removeAllObjects];
    [self.titles removeAllObjects];
    
    // Get tabCount from dataSource
    self.tabCount = [self.delegate numberOfTabsForViewPager:self];
    
    // Populate arrays with [NSNull null];
    self.tabs = [NSMutableArray arrayWithCapacity:self.tabCount];
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        [self.tabs addObject:[NSNull null]];
    }
    
    self.titles = [NSMutableArray arrayWithCapacity:self.tabCount];
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        [self.titles addSafeObject:[NSNull null]];
    }
    
    self.contents = [NSMutableArray arrayWithCapacity:self.tabCount];
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        [self.contents addObject:[NSNull null]];
    }
    
    //是否可以滑动  默认是NO,可以滑动
    if (!self.noScroll) {
        
        if (!self.tabsView) {
            
            self.tabsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, self.hideNavigationBar ? STATUSBAR_HEIGHT : NAVBAR_HEIGHT, CGRectGetWidth(self.view.frame), TabsViewHeight)];
            self.tabsView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            self.tabsView.backgroundColor = Color_White;
            self.tabsView.scrollsToTop = NO;
            self.tabsView.showsHorizontalScrollIndicator = NO;
            self.tabsView.showsVerticalScrollIndicator = NO;
            self.tabsView.delegate = self;
            self.tabsView.tag = kTabsView;
            [self.view insertSubview:self.tabsView atIndex:0];
            
        }
        
    } else {
        self.singleTabsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, self.hideNavigationBar ? STATUSBAR_HEIGHT : NAVBAR_HEIGHT, CGRectGetWidth(self.view.frame), TabsViewHeight)];
        self.singleTabsView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.singleTabsView];
    }
    
    if (!_bottomLine) {
        self.bottomLine = [[UIView alloc] init];
        self.bottomLine.width = SCREEN_WIDTH;
        self.bottomLine.height = .5f;
        self.bottomLine.bottom = self.tabsView.bottom + 0.5;
        self.bottomLine.backgroundColor = Color_Gray209;
        [self.view addSubview:self.bottomLine];
    }
    
    
    // Add tab views to _tabsView
    CGFloat contentSizeWidth = 0;
    
    
    CGFloat tabWidth = SCREEN_WIDTH / self.tabCount;
    for (NSUInteger i = 0; i < self.tabCount; i++) {
        
        UIView *tabView = [self tabViewAtIndex:i];
        
        CGRect frame = tabView.frame;
        
        
        if (!self.noScroll) {
            
            frame.origin.x = contentSizeWidth + 13.5;
            
            tabView.frame = frame;
            tabView.centerY = TabsViewHeight / 2;
            
            [self.tabsView addSubview:tabView];
            contentSizeWidth += CGRectGetWidth(tabView.frame) + 30;
        } else {
            frame.size.width = tabWidth - 20;
            tabView.frame = frame;
            tabView.centerX = tabWidth * i + tabWidth / 2;
            tabView.centerY = TabsViewHeight / 2;
            
            for (UILabel *titleLabel in tabView.subviews) {
                if (titleLabel) {
                    titleLabel.textColor = Color_Gray153;
                    titleLabel.font = FONT(14);
                    [titleLabel sizeToFit];
                    titleLabel.centerX = tabView.width / 2;
                }
            }
            
            [self.singleTabsView addSubview:tabView];
        }
        
        
        // To capture tap events
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        tabView.userInteractionEnabled = YES;
        [tabView addGestureRecognizer:tapGestureRecognizer];
    }
    
    self.tabsView.contentSize = CGSizeMake(contentSizeWidth, TabsViewHeight);
    
    //颜色条
    if (!_selectedBorder) {
        
        _selectedBorder = [[UIView alloc] initWithFrame:CGRectZero];
        _selectedBorder.height = 1.5;
        _selectedBorder.backgroundColor = _choosedColor ? _choosedColor : Color_Red6;
    }
    if (!self.noScroll) {
        _selectedBorder.bottom = self.tabsView.height;
        [self.tabsView addSubview:_selectedBorder];
    } else {
        _selectedBorder.bottom = self.singleTabsView.height;
        [self.singleTabsView addSubview:_selectedBorder];
    }
    
    // Add contentView
    
    if (!self.contentView) {
        
        self.contentView = self.pageViewController.view;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.contentView.backgroundColor = self.contentViewBackgroundColor;
        self.contentView.bounds = self.view.bounds;
        
        [self.view insertSubview:self.contentView atIndex:0];
    }
    
    
    [self selectTabAtIndex:0 noSwipe:NO];
    
}

- (UIView *)tabViewAtIndex:(NSUInteger)index {
    
    if (index >= self.tabCount) {
        return nil;
    }
    
    if ([[self.tabs objectAtIndex:index] isEqual:[NSNull null]]) {
        
        // Get view from dataSource
        UILabel *tabViewContent = [self.delegate viewPager:self tabForTabAtIndex:index];
        tabViewContent.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //        tabViewContent.centerX = tabViewContent.width / 2;
        //        tabViewContent.centerY = TabsViewHeight / 2;
        
        UIView *tabView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tabViewContent.width + 10, TabsViewHeight)];
        tabViewContent.centerX = tabView.width / 2;
        tabViewContent.centerY = tabView.height / 2;
        [tabView addSubview:tabViewContent];
        
        
        // Replace the null object with tabView
        [self.tabs replaceObjectAtIndex:index withObject:tabView];
    }
    
    return [self.tabs objectAtIndex:index];
}

- (void)handleTapGesture:(id)sender {
    
    // Get the desired page's index
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIView *tabView = tapGestureRecognizer.view;
    __block NSUInteger index = [self.tabs indexOfObject:tabView];
    
    
    //if Tap is not selected Tab(new Tab)
    if (self.activeTabIndex != index) {
        // Select the tab
        [self selectTabAtIndex:index noSwipe:NO];
    }
}

- (void)selectTabAtIndex:(NSUInteger)index noSwipe:(BOOL)noSwipe {
    
    
    if (index >= self.tabCount) {
        return;
    }
    
    self.animatingToTab = YES;
    
    // Set activeTabIndex
    self.activeTabIndex = index;
    
    // Set activeContentIndex
    self.activeContentIndex = index;
    
    if (!self.noScroll) {
        
        UIView *tabView = [self tabViewAtIndex:index];
        CGRect frame = tabView.frame;
        
        [UIView animateWithDuration:noSwipe ? 0 : 0.2 animations:^{//noSwipe=yes, 无动画, =no, 有动画
            
            self.tabsView.contentOffset = CGPointMake(frame.origin.x - self.tabsView.width / 2 + frame.size.width / 2, 0);
            
            
            if (self.tabsView.contentOffset.x < 0) {
                self.tabsView.contentOffset = CGPointMake(0, 0);
            }
            
            if (self.tabsView.contentOffset.x > self.tabsView.contentSize.width - self.tabsView.width) {
                self.tabsView.contentOffset = CGPointMake(self.tabsView.contentSize.width - self.tabsView.width, 0);
            }
            
            
            if (self.tabsView.contentOffset.x > 0) {
                self.bgView.hidden = NO;
                if (self.activeTabIndex == 0) {
                    self.firstSelectedBorder.hidden = NO;
                } else {
                    self.firstSelectedBorder.hidden = YES;
                }
                
            }
            else if (self.tabsView.contentOffset.x <= 0) {
                [self performSelector:@selector(bgViewHidden) withObject:nil afterDelay:0.3];
            }
        }];
        
    }
    //移动下划线与动画
    [UIView animateWithDuration:0.2 animations:^{
        [self initSelector];
    }];
    
    
    //    self.choosedTitle = [self titleAtIndex:index];
    
}

- (void)initSelector
{
    UIView *tabView = [self tabViewAtIndex:self.activeTabIndex];
    
    CGFloat width = tabView.width;
    CGFloat selectorWidth = width * 1.2;
    
    _selectedBorder.width = selectorWidth;
    _selectedBorder.centerX = tabView.centerX;
    
    
}

- (void)setActiveTabIndex:(NSUInteger)activeTabIndex {
    
    UIView *activeTabView;
    
    // Set to-be-inactive tab unselected
    activeTabView = [self tabViewAtIndex:self.activeTabIndex];
    for (UILabel *titleLabel in activeTabView.subviews) {
        if (titleLabel) {
            titleLabel.textColor = Color_Gray153;
            titleLabel.font = FONT(14);
            [titleLabel sizeToFit];
            titleLabel.centerX = activeTabView.width / 2;
        }
    }
    
    // Set to-be-active tab selected
    activeTabView = [self tabViewAtIndex:activeTabIndex];
    for (UILabel *titleLabel in activeTabView.subviews) {
        if (titleLabel) {
            titleLabel.textColor = self.choosedColor ? self.choosedColor : Color_Black;
            titleLabel.font = self.noSelectBold ? FONT(14) : FONT(16);
            [titleLabel sizeToFit];
            titleLabel.centerX = activeTabView.width / 2;
        }
    }
    
    
    // Set current activeTabIndex
    _activeTabIndex = activeTabIndex;
    
}

- (void)setActiveContentIndex:(NSUInteger)activeContentIndex {
    
    // Get the desired viewController
    UIViewController *viewController = [self viewControllerAtIndex:activeContentIndex];
    
    if (!viewController) {
        viewController = [[UIViewController alloc] init];
        viewController.view = [[UIView alloc] init];
        viewController.view.backgroundColor = [UIColor clearColor];
    }
    
    // __weak pageViewController to be used in blocks to prevent retaining strong reference to self
    __weak TTViewPagerController *weakSelf = self;
    
    if (activeContentIndex == self.activeContentIndex) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.pageViewController setViewControllers:@[viewController]
                                              direction:UIPageViewControllerNavigationDirectionForward
                                               animated:NO
                                             completion:^(BOOL completed) {
                                                 __strong TTViewPagerController *strongSelf = weakSelf;
                                                 //                                             DBG(@"%@===============================1",weakSelf);
                                                 strongSelf.animatingToTab = NO;
                                             }];
        });
    } else if (!(activeContentIndex + 1 == self.activeContentIndex || activeContentIndex - 1 == self.activeContentIndex)) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.pageViewController setViewControllers:@[viewController]
                                              direction:(activeContentIndex < self.activeContentIndex) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward
                                               animated:NO
                                             completion:^(BOOL completed) {
                                                 __strong TTViewPagerController *strongSelf = weakSelf;
                                                 //                                             DBG(@"%@===============================2",weakSelf);
                                                 strongSelf.animatingToTab = NO;
                                                 
                                                 // Set the current page again to obtain synchronisation between tabs and content
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     [weakSelf.pageViewController setViewControllers:@[viewController]
                                                                                           direction:(activeContentIndex < weakSelf.activeContentIndex) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward
                                                                                            animated:NO
                                                                                          completion:nil];
                                                 });
                                             }];
        });
        
    } else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.pageViewController setViewControllers:@[viewController]
                                              direction:(activeContentIndex < self.activeContentIndex) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward
                                               animated:NO
                                             completion:^(BOOL completed) {
                                                 __strong TTViewPagerController *strongSelf = weakSelf;
                                                 //                                             DBG(@"%@===============================3",weakSelf);
                                                 strongSelf.animatingToTab = NO;
                                             }];
        });
        
    }
    
    _activeContentIndex = activeContentIndex;
}



- (void)selectTabAtIndex:(NSUInteger)index {
    [self selectTabAtIndex:index noSwipe:NO];
}

- (void)bgViewHidden {
    if (self.tabsView.contentOffset.x <= 0) {
        self.bgView.hidden = YES;
    }
}

- (NSUInteger)indexForTabView:(UIView *)tabView {
    
    return [self.tabs indexOfObject:tabView];
}

- (NSUInteger)indexForViewController:(UIViewController *)viewController {
    
    return [self.contents indexOfObject:viewController];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (index >= self.tabCount) {
        return nil;
    }
    
    if ([[self.contents objectAtIndex:index] isEqual:[NSNull null]]) {
        
        UIViewController *viewController;
        
        if ([self.delegate respondsToSelector:@selector(viewPager:contentViewControllerForTabAtIndex:)]) {
            viewController = [self.delegate viewPager:self contentViewControllerForTabAtIndex:index];
        } else if ([self.delegate respondsToSelector:@selector(viewPager:contentViewForTabAtIndex:)]) {
            
            UIView *view = [self.delegate viewPager:self contentViewForTabAtIndex:index];
            
            view.frame = self.contentView.bounds;
            
            viewController = [UIViewController new];
            viewController.view = view;
        } else {
            viewController = [[UIViewController alloc] init];
            viewController.view = [[UIView alloc] init];
        }
        
        [self.contents replaceObjectAtIndex:index withObject:viewController];
    }
    
    return [self.contents objectAtIndex:index];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index++;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexForViewController:viewController];
    index--;
    return [self viewControllerAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    UIViewController *viewController = self.pageViewController.viewControllers[0];
    
    // Select tab
    NSUInteger index = [self indexForViewController:viewController];
    [self selectTabAtIndex:index noSwipe:NO];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.tag == kTabsView) {
        
        
        if (scrollView.isDragging) {
            if (scrollView.contentOffset.x <= 0) {
                self.bgView.hidden = YES;
            } else {
                self.bgView.hidden = NO;
                if (self.activeTabIndex == 0) {
                    self.firstSelectedBorder.hidden = NO;
                } else {
                    self.firstSelectedBorder.hidden = YES;
                }
            }
        }
        
    } else {
        
        if ([self.actualDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [self.actualDelegate scrollViewDidScroll:scrollView];
        }
        
    }
}


@end
