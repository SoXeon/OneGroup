//
//  DPAnnotation.m
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPAnnotation.h"

@interface DPAnnotation()
{
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
    NSString *_subtitle;
}

@property (strong,nonatomic) NSString *str1;
@property (copy,nonatomic) NSString *str2;

@end

@implementation DPAnnotation 

-(id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle
{
    self = [super init];
    
    if (self) {
        _coordinate = coordinate;
        _title = title;
        _subtitle = subtitle;
        
        NSMutableString *string = [NSMutableString string];
        [string setString:@"abc"];
        
        self.str1 = string;
        self.str2 = string;
        
        [string setString:@"123"];
    }
    
    return self;
}

-(CLLocationCoordinate2D)coordinate
{
    return _coordinate;
}

-(NSString *)title
{
    return _title;
}

-(NSString *)subtitle
{
    return _subtitle;
}

@end
