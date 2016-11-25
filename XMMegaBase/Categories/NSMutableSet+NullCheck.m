//
//  NSMutableSet+NullCheck.m
//  HongBao
//
//  Created by Ivan on 15/10/13.
//  Copyright © 2015年 ivan. All rights reserved.

#import "NSMutableSet+NullCheck.h"

@implementation NSMutableSet (NullCheck)
- (void)addSafeObject:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}
@end
