//
//  NSString+DP.h
//  一团
//
//  Created by DP on 14-5-21.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DP)
//生成一个保留fraction位的字符串（裁剪微博多余的0）
+(NSString *)stringWithDouble:(double)value fractionCount:(int)fractionCount;
@end
