//
//  NSDate+DP.m
//  一团
//
//  Created by DP on 14-5-23.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "NSDate+DP.h"

@implementation NSDate (DP)
+ (NSDateComponents *)compareFrom:(NSDate *)from to:(NSDate *)to
{
    //日历对象
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSUInteger flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    return  [calendar components:flags fromDate:from toDate:to options:0];
}

-(NSDateComponents *)compare:(NSDate *)other
{
    return [NSDate compareFrom:self to:other];
}
@end
