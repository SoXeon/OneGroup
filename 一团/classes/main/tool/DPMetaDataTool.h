//
//  DPMetaData.h
//  一团
//
//  Created by DP on 14-5-14.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class DPCity;

@interface DPMetaDataTool : NSObject
singleton_interface(DPMetaDataTool)
@property (nonatomic,strong,readonly) NSArray *totalCitySections;//所有城市组数据
@property (nonatomic,strong,readonly) NSDictionary *totalCities;//所有城市
@property (nonatomic,strong) DPCity *currentCity;//当前选中的城市
@property (nonatomic,strong,readonly) NSArray *totalCategories;//所有的分类数据
//所有的排序数据
@property (nonatomic,strong,readonly)NSArray *totalOrders;
@end
