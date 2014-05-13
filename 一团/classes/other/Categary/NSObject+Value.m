//
//  NSObject+Value.m
//  SinaWeibo
//
//  Created by mj on 13-8-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSObject+Value.h"
#import <objc/message.h>
#import <objc/runtime.h>

@implementation NSObject (Value)
- (void)setValues:(NSDictionary *)values
{
    Class c = [self class];
    
    while (c) {
        // 1.获得所有的成员变量
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList(c, &outCount);
        
        for (int i = 0; i<outCount; i++) {
            Ivar ivar = ivars[i];
            
            // 2.属性名
            NSMutableString *name = [NSMutableString stringWithUTF8String:ivar_getName(ivar)];
            
            // 删除最前面的_
            [name replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
            
            // 3.取出属性值
            NSString *key = name;
            if ([key isEqualToString:@"desc"]) {
                key = @"description";
            }
            if ([key isEqualToString:@"ID"]) {
                key = @"id";
            }
            id value = values[key];
            if (!value) continue;
            
            // 4.SEL
            // 首字母
            NSString *cap = [name substringToIndex:1];
            // 变大写
            cap = cap.uppercaseString;
            // 将大写字母调换掉原首字母
            [name replaceCharactersInRange:NSMakeRange(0, 1) withString:cap];
            // 拼接set
            [name insertString:@"set" atIndex:0];
            // 拼接冒号:
            [name appendString:@":"];
            SEL selector = NSSelectorFromString(name);
            
            // 5.属性类型
            NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            
            if ([type hasPrefix:@"@"]) { // 对象类型
                objc_msgSend(self, selector, value);
            } else  { // 非对象类型
                if ([type isEqualToString:@"d"]) {
                    objc_msgSend(self, selector, [value doubleValue]);
                } else if ([type isEqualToString:@"f"]) {
                    objc_msgSend(self, selector, [value floatValue]);
                } else if ([type isEqualToString:@"i"]) { 
                    objc_msgSend(self, selector, [value intValue]);
                }  else { 
                    objc_msgSend(self, selector, [value longLongValue]);
                }
            }
        }
        
        c = class_getSuperclass(c);
    }
}
@end
