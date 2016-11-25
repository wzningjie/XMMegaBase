//
//  ShortcutMacro.h
//  HongBao
//
//  Created by Ivan on 15/10/5.
//  Copyright © 2015年 ivan. All rights reserved.
//

#ifndef ShortcutMacro_h
#define ShortcutMacro_h

// rgb取色
#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define RGB(r,g,b)          RGBA(r,g,b,1)

// hex取色
#define CHEXA(hex,a)       [UIColor colorWithHexString:hex alpha:a]
#define CHEX(hex)          CHEXA(hex,1)

// 字体设置
#define FONT(s)             [UIFont systemFontOfSize:s]
#define BOLD_FONT(s)        [UIFont boldSystemFontOfSize:s]

// debug
#ifdef DEBUG
#define DBG(format, ...)    NSLog(format, ## __VA_ARGS__)
#else
#define DBG(format, ...)
#endif

#define DBGRect(rect)       DBG(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define DBGSize(size)       DBG(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define DBGPoint(point)         DBG(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)

//weakify & strongify
#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(weak))) __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__attribute__((objc_ownership(strong))) __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

//IM
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* ShortcutMacro_h */
