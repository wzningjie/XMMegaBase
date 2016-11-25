//
//  TTUrlHelper.h
//  HongBao
//
//  Created by Ivan on 16/3/9.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTUrlHelper : NSObject

+ (NSString *)addParamsToUrl:(NSString *)url fromDictionary:(NSDictionary *)params;

@end
