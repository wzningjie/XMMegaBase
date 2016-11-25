//
//  NSMutableDictionary+NullCheck.m
//  HongBao
//
//  Created by Ivan on 15/10/13.
//  Copyright © 2015年 ivan. All rights reserved.

#import "NSMutableDictionary+NullCheck.h"

@implementation NSMutableDictionary (NullCheck)

- (void)setSafeObject:(id)anObject forKey:(id)aKey {
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
