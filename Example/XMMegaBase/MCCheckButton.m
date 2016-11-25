//
//  MCCheckButton.m
//  XMMegaBase
//
//  Created by marco on 8/12/16.
//  Copyright © 2016 marco. All rights reserved.
//

#import "MCCheckButton.h"

@interface MCCheckButton ()
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *tickLayer;
@end

@implementation MCCheckButton

@synthesize normalTickColor=_normalTickColor;
@synthesize normalBackgroundColor=_normalBackgroundColor;
@synthesize normalBorderColor = _normalBorderColor;
@synthesize selectedTickColor = _selectedTickColor;
@synthesize selectedBorderColor = _selectedBorderColor;
@synthesize selectedBackgroundColor = _selectedBackgroundColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self ) {
        
        //[self setImage:[self defaultSelectedImage] forState:UIControlStateSelected];
        //[self setImage:[self defaultImage] forState:UIControlStateNormal];
        //[self setImage:[self defaultNormalImage] forState:UIControlStateHighlighted];
        [self.layer addSublayer:self.circleLayer];
        [self.layer addSublayer:self.tickLayer];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, 32, 32)]) {
        
        [self.layer addSublayer:self.circleLayer];
        [self.layer addSublayer:self.tickLayer];
    }
    return self;
}


#pragma property

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected) {
        self.circleLayer.strokeColor = [self.selectedBorderColor CGColor];
        self.circleLayer.fillColor = [self.selectedBackgroundColor CGColor];
        self.tickLayer.fillColor = [self.selectedTickColor CGColor];
    }else{
        self.circleLayer.strokeColor = [self.normalBorderColor CGColor];
        self.circleLayer.fillColor = [self.normalBackgroundColor CGColor];
        self.tickLayer.fillColor = [self.normalTickColor CGColor];
    }
}

- (CAShapeLayer*)circleLayer
{
    if (!_circleLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.bounds = CGRectMake(0, 0, 20, 20);
        layer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 19, 19)];
        layer.path = [ovalPath CGPath];
        layer.strokeColor = [self.normalBorderColor CGColor];
        layer.lineWidth = 1;
        layer.fillColor = [self.normalBackgroundColor CGColor];
        _circleLayer = layer;
    }
    return _circleLayer;
}

- (CAShapeLayer*)tickLayer
{
    if (!_tickLayer) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.bounds = CGRectMake(0, 0, 20, 20);
        layer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        UIBezierPath* tickPath = [UIBezierPath bezierPath];
        [tickPath moveToPoint: CGPointMake(4.5, 9)];
        [tickPath addLineToPoint: CGPointMake(7.5, 12)];
        [tickPath addLineToPoint: CGPointMake(14.5, 5)];
        [tickPath addLineToPoint: CGPointMake(15.5, 6)];
        [tickPath addLineToPoint: CGPointMake(7.5, 14)];
        [tickPath addLineToPoint: CGPointMake(3.5, 10)];
        [tickPath addLineToPoint: CGPointMake(4.5, 9)];
        [tickPath closePath];
        layer.path = [tickPath CGPath];
        layer.fillColor = [self.normalTickColor CGColor];
        _tickLayer = layer;
    }
    return _tickLayer;
}


- (UIColor*)normalTickColor
{
    if (!_normalTickColor) {
        return [UIColor clearColor];
    }else{
        return _normalTickColor;
    }
}

- (void)setNormalTickColor:(UIColor *)normalTickColor
{
    _normalTickColor = normalTickColor;
    if (!self.selected) {
        self.tickLayer.fillColor = [_normalTickColor CGColor];
    }
}


- (UIColor*)normalBorderColor
{
    if (!_normalBorderColor) {
        return [UIColor colorWithRed: 0.706 green: 0.706 blue: 0.706 alpha: 1];
    }else{
        return _normalBorderColor;
    }
}

- (void)setNormalBorderColor:(UIColor *)normalBorderColor
{
    _normalBorderColor = normalBorderColor;
    if (!self.selected) {
        self.circleLayer.strokeColor = [_normalBorderColor CGColor];
    }
}

- (UIColor*)normalBackgroundColor
{
    if (!_normalBackgroundColor) {
        return [UIColor clearColor];
    }else{
        return _normalBackgroundColor;
    }
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor
{
    _normalBackgroundColor = normalBackgroundColor;
    if (!self.selected) {
        self.circleLayer.fillColor = [_normalBackgroundColor CGColor];
    }
}

- (UIColor*)selectedTickColor
{
    if (!_selectedTickColor) {
        return [UIColor whiteColor];
    }else{
        return _selectedTickColor;
    }
}

- (void)setSelectedTickColor:(UIColor *)selectedTickColor
{
    _selectedTickColor = selectedTickColor;
    if (self.selected) {
        self.tickLayer.fillColor = [_selectedTickColor CGColor];
    }
}

- (UIColor*)selectedBorderColor
{
    if (!_selectedBorderColor) {
        return [UIColor colorWithRed:254/255.0f green:85/255.0f blue:46/255.0f alpha:1.0];
    }else{
        return _selectedBorderColor;
    }
}

- (void)setSelectedBorderColor:(UIColor *)selectedBorderColor
{
    _selectedBorderColor = selectedBorderColor;
    if (self.selected) {
        self.circleLayer.strokeColor = [_selectedBorderColor CGColor];
    }
}

- (UIColor*)selectedBackgroundColor
{
    if (!_selectedBackgroundColor) {
        return [UIColor colorWithRed:254/255.0f green:85/255.0f blue:46/255.0f alpha:1.0];
    }else{
        return _selectedBackgroundColor;
    }
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor
{
    _selectedBackgroundColor = selectedBackgroundColor;
    if (self.selected) {
        self.circleLayer.fillColor = [_selectedBackgroundColor CGColor];
    }
}

//- (UIImage*)defaultSelectedImage
//{
//    UIImage *image = [UIImage imageWithIdentifier:@"com.xiaoma.mcCheckButton.defaultSelected" forSize:CGSizeMake(19, 19) andDrawingBlock:^{
//        // Drawing code…
//        //// Color Declarations
//        UIColor* color3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
//        
//        //// Oval Drawing
//        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0, 0, 19, 19)];
//        [self.selectedBackgroundColor setFill];
//        [ovalPath fill];
//        
//        
//        //// Bezier 2 Drawing
//        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
//        [bezier2Path moveToPoint: CGPointMake(4.5, 9)];
//        [bezier2Path addLineToPoint: CGPointMake(7.5, 12)];
//        [bezier2Path addLineToPoint: CGPointMake(14.5, 5)];
//        [bezier2Path addLineToPoint: CGPointMake(15.5, 6)];
//        [bezier2Path addLineToPoint: CGPointMake(7.5, 14)];
//        [bezier2Path addLineToPoint: CGPointMake(3.5, 10)];
//        [bezier2Path addLineToPoint: CGPointMake(4.5, 9)];
//        [bezier2Path closePath];
//        [color3 setFill];
//        [bezier2Path fill];
//
//    }];
//    return image;
//}
//
//- (UIImage*)defaultNormalImage
//{
//    UIImage *image = [UIImage imageWithIdentifier:@"com.xiaoma.mcCheckButton.defaultNormal" forSize:CGSizeMake(20, 20) andDrawingBlock:^{
//        // Drawing code…
//        //// Color Declarations
//        UIColor* color5 = [UIColor colorWithRed: 0.706 green: 0.706 blue: 0.706 alpha: 1];
//        
//        //// Oval Drawing
//        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 19, 19)];
//        [color5 setStroke];
//        ovalPath.lineWidth = 1;
//        [ovalPath stroke];
//        
//    }];
//    return image;
//}
//
//- (UIImage*)defaultImage
//{
//    UIImage *image = [UIImage imageWithIdentifier:@"com.xiaoma.mcCheckButton.defaultNormal" forSize:CGSizeMake(20, 20) andDrawingBlock:^{
//        // Drawing code…
//        
//        //// Oval Drawing
//        UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(0.5, 0.5, 19, 19)];
//        [self.normalBorderColor setStroke];
//        ovalPath.lineWidth = 1;
//        [ovalPath stroke];
//        
//        //// Oval Drawing
//        [self.normalBackgroundColor setFill];
//        [ovalPath fill];
//
//        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
//        [bezier2Path moveToPoint: CGPointMake(4.5, 9)];
//        [bezier2Path addLineToPoint: CGPointMake(7.5, 12)];
//        [bezier2Path addLineToPoint: CGPointMake(14.5, 5)];
//        [bezier2Path addLineToPoint: CGPointMake(15.5, 6)];
//        [bezier2Path addLineToPoint: CGPointMake(7.5, 14)];
//        [bezier2Path addLineToPoint: CGPointMake(3.5, 10)];
//        [bezier2Path addLineToPoint: CGPointMake(4.5, 9)];
//        [bezier2Path closePath];
//        [self.normalTickColor setFill];
//        [bezier2Path fill];
//
//    }];
//    return image;
//}

@end
