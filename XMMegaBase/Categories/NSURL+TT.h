//
//  NSURL+TT.h
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSURL (TT)

@property (nonatomic, strong) NSDictionary *parameters;


- (NSString *)parameterForKey:(NSString *)key;

- (id)objectForKeyedSubscript:(id)key NS_AVAILABLE(10_8, 6_0);


@end