//
//  NSURL+TT.m
//  HongBao
//
//  Created by Ivan on 16/1/21.
//  Copyright © 2016年 ivan. All rights reserved.
//

#import "NSURL+TT.h"
#import <objc/runtime.h>
#import "NSString+TT.h"

static void *kURLParametersDictionaryKey;

@implementation NSURL (TT)

- (void)scanParameters {
    
    if (self.isFileURL) {
        return;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString: self.absoluteString];
    [scanner setCharactersToBeSkipped: [NSCharacterSet characterSetWithCharactersInString:@"&?"] ];
    //skip to ?
    [scanner scanUpToString:@"?" intoString: nil];
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *tmpValue;
    while ([scanner scanUpToString:@"&" intoString:&tmpValue]) {
        
        NSArray *components = [tmpValue componentsSeparatedByString:@"="];
        
        if (components.count >= 2) {
            NSString *key = [[components[0] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding] urldecode];
            NSString *value = [[components[1] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding] urldecode];
            
            parameters[key] = value;
        }
    }
    
    self.parameters = parameters;
}

- (id)objectForKeyedSubscript:(id)key {
    
    return self.parameters[key];
}


- (NSString *)parameterForKey:(NSString *)key {
    
    return self.parameters[key];
}

- (NSDictionary *)parameters {
    
    NSDictionary *result = objc_getAssociatedObject(self, &kURLParametersDictionaryKey);
    
    if (!result) {
        [self scanParameters];
    }
    
    return objc_getAssociatedObject(self, &kURLParametersDictionaryKey);
}

- (void)setParameters:(NSDictionary *)parameters {
    
    objc_setAssociatedObject(self, &kURLParametersDictionaryKey, parameters, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

@end