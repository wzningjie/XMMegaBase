//
//  TTCheckButton.m
//  HongBao
//
//  Created by Ivan on 16/2/18.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTCheckButton.h"
#import "UIImage+TT.h"
#import "XMAppThemeHelper.h"

@interface TTCheckButton ()
@property (nonatomic, strong) NSString *normalModuleName;
@property (nonatomic, strong) NSString *disabledModuleName;
@property (nonatomic, strong) NSString *selectedModuleName;


@property (nonatomic, strong) NSString *imageNameNormal;
@property (nonatomic, strong) NSString *imageNameDisabled;
@property (nonatomic, strong) NSString *imageNameSelected;

@end

@implementation TTCheckButton

- (instancetype) init {
    
    self = [TTCheckButton buttonWithType:UIButtonTypeCustom];
    
    if ( self ) {
        _imageNameNormal = @"icon_unselected";
        _normalModuleName = ModuleName;
        
        _imageNameDisabled = @"icon_unselected";
        _disabledModuleName = ModuleName;
        
        _imageNameSelected = @"icon_selected";
        _selectedModuleName = ModuleName;


        NSString *normalIcon = [XMAppThemeHelper defaultTheme].checkButtonNormalIconName;
        if (normalIcon) {
            _imageNameNormal = normalIcon;
            _normalModuleName = nil;
        }
        NSString *disablelIcon = [XMAppThemeHelper defaultTheme].checkButtonDisableIconName;
        if (disablelIcon) {
            _imageNameDisabled = disablelIcon;
            _disabledModuleName = nil;
        }
        NSString *selectedIcon = [XMAppThemeHelper defaultTheme].checkButtonSelectedIconName;
        if (selectedIcon) {
            _imageNameSelected = selectedIcon;
            _selectedModuleName = nil;
        }
        
        UIImage *imageNormal = [UIImage imageNamed:self.imageNameNormal module:self.normalModuleName];
        UIImage *imageDisabled = [UIImage imageNamed:self.imageNameDisabled module:self.disabledModuleName];
        UIImage *imageSelected = [UIImage imageNamed:self.imageNameSelected module:self.selectedModuleName];
        
        [self setImage:imageNormal forState:UIControlStateNormal];
        [self setImage:imageDisabled forState:UIControlStateDisabled];
        [self setImage:imageSelected forState:UIControlStateSelected];
        
        self.frame = CGRectMake(0, 0, 32, 32);
        
    }
    
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames {
    
    return [[[self class]alloc]initWithFrame:frame imageNames:imageNames inModule:nil];
    
}

- (instancetype) initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNames inModule:(NSString*)moduleName
{
    if ( imageNames.count != 3 ) {
        return nil;
    }
    if (self = [super initWithFrame:frame]) {
        
        self.imageNameNormal = imageNames[0];
        self.imageNameDisabled = imageNames[1];
        self.imageNameSelected = imageNames[2];
        
        self.normalModuleName = moduleName;
        self.disabledModuleName = moduleName;
        self.selectedModuleName = moduleName;
        
        UIImage *imageNormal = [UIImage imageNamed:self.imageNameNormal module:self.normalModuleName];
        UIImage *imageDisabled = [UIImage imageNamed:self.imageNameDisabled module:self.disabledModuleName];
        UIImage *imageSelected = [UIImage imageNamed:self.imageNameSelected module:self.selectedModuleName];
        
        [self setImage:imageNormal forState:UIControlStateNormal];
        [self setImage:imageDisabled forState:UIControlStateDisabled];
        [self setImage:imageSelected forState:UIControlStateSelected];

    }
    return self;
}
@end
