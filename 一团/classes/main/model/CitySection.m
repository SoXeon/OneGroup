//
//  CitySection.m
//  一团
//
//  Created by DP on 14-5-13.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "CitySection.h"
#import "DPCity.h"
#import "NSObject+Value.h"
@implementation CitySection
-(void)setCities:(NSArray *)cities
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in cities) {
        DPCity *city = [[DPCity alloc]init];
        
        [city setValues:dict];
        
        [array addObject:city];
    }
    _cities = array;
}
@end
