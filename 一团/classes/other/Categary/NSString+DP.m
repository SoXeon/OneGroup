//
//  NSString+DP.m
//  一团
//
//  Created by DP on 14-5-21.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "NSString+DP.h"

@implementation NSString (DP)
+(NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount
{
    if (fractionCount < 0 ) {
        return nil;
    }
    
    NSString *fmt = [NSString stringWithFormat:@"%%.%df",fractionCount];
    
    //生成保留fractionCount位小数的字符串
    NSString *str = [NSString stringWithFormat:fmt,value];
    
    //如果没有小数直接返回
    if ([str rangeOfString:@"."].length == 0) {
        return str;
    }
    //不断删除最后一个0,及最后一个点
    int index = str.length - 1;
    unichar currentChar = [str characterAtIndex:index];
    
    while (currentChar == '0' || currentChar == '.') {
        if (currentChar == '.') {
            return [str substringToIndex:index];
        }
        index --;
        currentChar = [str characterAtIndex:index];
    }
    return [str substringToIndex:index + 1];
}

@end
