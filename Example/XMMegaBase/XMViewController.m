//
//  XMViewController.m
//  XMMegaBase
//
//  Created by marco on 08/01/2016.
//  Copyright (c) 2016 marco. All rights reserved.
//

#import "XMViewController.h"
#import "TTNavigationController.h"
#import "XMBaseViewController.h"
#import "ColorMarco.h"
#import "KeyMarco.h"
#import "MCCheckButton.h"
#import "TTCheckButton.h"

@interface XMViewController ()
@property (nonatomic, strong) MCCheckButton *checkButton;
@property (nonatomic, strong) TTCheckButton *ttButton;

@end

@implementation XMViewController

- (instancetype)initWithTitle:(NSString *)tite
{
    self = [super init];
    if (self) {
        self.title = tite;
        self.tabbarItem = [[TTTabbarItem alloc] initWithTitle:self.title titleColor:Color_Gray146 selectedTitleColor:Color_Yellow icon:[UIImage imageNamed:@"icon_tabbar_mall_normal"] selectedIcon:[UIImage imageNamed:@"icon_tabbar_mall_selected"]];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = Color_Gray245;

    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(80, 80, 100, 40)];
    [button setTitle:@"Press" forState:UIControlStateNormal];
    [button setTitleColor:Color_Red forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
    [self.view addSubview:self.button];
    
    self.checkButton = [[MCCheckButton alloc]init];
    self.checkButton.center = CGPointMake(50, 280);
    [self.checkButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.checkButton];
    
    self.ttButton = [[TTCheckButton alloc]init];
    self.ttButton.center = CGPointMake(90, 280);
    [self.ttButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ttButton];
    

    [self performSelector:@selector(removeLaunch) withObject:nil afterDelay:1.f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender
{
    XMBaseViewController *vc = [[XMBaseViewController alloc]init];
    XMBaseViewController *vc2 = [[XMBaseViewController alloc]init];

    TTNavigationController *nav = [[TTNavigationController alloc]initWithRootViewController:vc];
    [nav pushViewController:vc2 animated:NO];
    [self presentViewController:nav animated:NO completion:nil];
}

- (void)buttonPressed:(id)sender
{
    UIButton *button = (UIButton*)sender;
    button.selected = !button.selected;
}

- (void)removeLaunch
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNOTIFY_APP_LAUNCH_REMOVE object:nil];

}
@end
