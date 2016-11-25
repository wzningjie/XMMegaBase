//
//  NSMutableArray+NullCheck.h
//  HongBao
//
//  Created by Ivan on 15/10/13.
//  Copyright © 2015年 ivan. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSMutableArray (NullCheck)

- (void)addSafeObject:(id)anObject;
- (void)insertSafeObject:(id)anObject atIndex:(NSUInteger)index;
- (id)objectAtSafeIndex:(NSUInteger)index;
- (void)addObjectsFromSafeArray:(NSArray *)otherArray;

@end
