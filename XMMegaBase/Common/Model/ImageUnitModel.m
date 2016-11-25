//
//  ImageUnitModel.m
//  HongBao
//
//  Created by Ivan on 16/2/10.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "ImageUnitModel.h"

@implementation ImageUnitModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    
    if ( [propertyName isEqualToString:@"ar"] || [propertyName isEqualToString:@"w"] || [propertyName isEqualToString:@"h"] ) {
        
        return YES;
    }
    return NO;
}

@end
