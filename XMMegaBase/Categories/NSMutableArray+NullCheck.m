//
//  NSMutableArray+NullCheck.m
//  HongBao
//
//  Created by Ivan on 15/10/13.
//  Copyright © 2015年 ivan. All rights reserved.
//

#import "NSMutableArray+NullCheck.h"

@implementation NSMutableArray (NullCheck)

- (void)addSafeObject:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
    }
}

- (void)insertSafeObject:(id)anObject atIndex:(NSUInteger)index {
    if (anObject) {
        [self insertObject:anObject atIndex:index];
    }
}

- (id)objectAtSafeIndex:(NSUInteger)index
{
    if (self.count > index) {
        
        return [self objectAtIndex:index];
    }
    else{
        
        return nil;
    }
}

- (void)addObjectsFromSafeArray:(NSArray *)otherArray
{
    if (otherArray && otherArray.count > 0) {
        
        [self addObjectsFromArray:otherArray];
    }
}
@end
