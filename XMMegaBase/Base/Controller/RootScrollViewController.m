//
//  RootScrollViewController.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//


#import "RootScrollViewController.h"

@interface RootScrollViewController ()

@end

@implementation RootScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)loadData {
    
}

- (void)addNavigationBar
{
    if (!self.hideNavigationBar) {
        [super addNavigationBar];
    }
    else
    {
        return;
    }
}

- (void)doRefresh
{
    
}

- (void)doReload
{
    
}

- (void)doLoadMore
{
    
}

- (void)startRefresh
{
    
}

- (void)finishRefresh
{
    
}

- (void)finishLoadMore
{
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.backToTopButton) {
        
        CGFloat currentPostion = scrollView.contentOffset.y;
        
        if (currentPostion > self.lastPosition)
        {
            self.lastPosition = currentPostion;
            self.backToTopButton.alpha = 0;
            self.isBackToTop = NO;
        }
        
        if (scrollView.contentOffset.y == 0) {
            self.backToTopButton.alpha = 0;
            self.isBackToTop = YES;
        }
        
    }
}


@end
