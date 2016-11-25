
//
//  NSMutableSet+NullCheck.h
//  HongBao
//
//  Created by Ivan on 15/10/13.
//  Copyright © 2015年 ivan. All rights reserved.
#import <Foundation/Foundation.h>

@interface NSMutableSet (NullCheck)

- (void)addSafeObject:(id)anObject;

@end
