//
//  NSDate+DP.h
//  一团
//
//  Created by DP on 14-5-23.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DP)
+(NSDateComponents *)compareFrom:(NSDate *)from to:(NSDate *)to;
-(NSDateComponents *)compare:(NSDate *)other;
@end
