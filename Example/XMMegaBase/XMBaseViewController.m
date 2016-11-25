//
//  XMBaseViewController.m
//  XMMegaBase
//
//  Created by marco on 8/3/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "XMBaseViewController.h"
#import "UIMacro.h"
#import "UIImage+TT.h"

@interface XMBaseViewController ()

@end

@implementation XMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBar];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 50, 20);
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(handleAddButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationBar.rightBarButton = addButton;
    
    [self.view addSubview:self.imageView];
    
    self.title = @"测试";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIImageView*)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 80, SCREEN_WIDTH-12*2, 40)];
        imageView.image = [UIImage imageNamed:@"btn_orange_bg_37" module:@"XMMegaBase"];
        _imageView = imageView;
    }
    return _imageView;
}

- (void)handleAddButton
{
    XMBaseViewController *vc = [[XMBaseViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
