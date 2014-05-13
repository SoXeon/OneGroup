//
//  DPCity.m
//  一团
//
//  Created by DP on 14-5-13.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPCity.h"
#import "DPDistrict.h"
#import "NSObject+Value.h"

@implementation DPCity
-(void)setDistricts:(NSArray *)districts
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dict in districts) {
        DPDistrict *district = [[DPDistrict alloc]init];
        
        [district setValues:dict];
        
        [array addObject:district];
    }
    _districts = array;
}

@end
