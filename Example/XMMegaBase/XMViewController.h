//
//  XMViewController.h
//  XMMegaBase
//
//  Created by marco on 08/01/2016.
//  Copyright (c) 2016 marco. All rights reserved.
//

#import "BaseViewController.h"

@interface XMViewController : BaseViewController


@property (nonatomic, strong) UIButton *button;

- (instancetype)initWithTitle:(NSString *)tite;

- (IBAction)buttonTapped:(id)sender;
@end
