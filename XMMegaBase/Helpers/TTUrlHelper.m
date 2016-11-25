//
//  TTUrlHelper.m
//  HongBao
//
//  Created by Ivan on 16/3/9.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "TTUrlHelper.h"
#import "NSString+TT.h"

@implementation TTUrlHelper

+ (NSString *)addParamsToUrl:(NSString *)url fromDictionary:(NSDictionary *)params;
{
    NSMutableString *_add = nil;
    if (NSNotFound != [url rangeOfString:@"?"].location) {
        _add = [NSMutableString stringWithString:@"&"];
    }else {
        _add = [NSMutableString stringWithString:@"?"];
    }
    for (NSString* key in [params allKeys]) {
        NSString *value = [params objectForKey:key];
        if (value && [value isKindOfClass:[NSString class]] && 0 < [value length]) {
            [_add appendFormat:@"%@=%@&",[key urlencode],[value urlencode]];
        }
    }
    NSInteger position = url.length;
    NSRange range = [url rangeOfString:@"#"];
    if (range.length > 0) {
        position = range.location;
    }
    NSMutableString *string = [url mutableCopy];
    [string insertString:[_add substringToIndex:[_add length] - 1] atIndex:position];
    return string;
}

@end
