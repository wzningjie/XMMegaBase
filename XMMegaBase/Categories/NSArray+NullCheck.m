//
//  NSArray+NullCheck.m
//  HongBao
//
//  Created by Ivan on 15/10/13.
//  Copyright © 2015年 ivan. All rights reserved.
//

#import "NSArray+NullCheck.h"

@implementation NSArray (NullCheck)

- (id)safeObjectAtIndex:(NSInteger)index
{
    id obj = nil;
    if (index < self.count) {
        obj = [self objectAtIndex:index];
    }
    return obj;
}
@end