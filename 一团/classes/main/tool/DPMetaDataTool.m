//
//  DPMetaData.m
//  一团
//
//  Created by DP on 14-5-14.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPMetaDataTool.h"
#import "CitySection.h"
#import "NSObject+Value.h"
#import "DPCity.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.data"]


@interface DPMetaDataTool()
{
    NSMutableArray *_visitedCityNames;//存储曾经访问过城市的名称
    NSMutableDictionary *_totalCities;//存放所有城市的key是城市名，value是城市对象
    CitySection *_visitedSection;//最近访问的城市组数组
}

@end

@implementation DPMetaDataTool
singleton_implementation(DPMetaDataTool)

- (id)init
{
    if (self = [super init]) {
        
        //存放所有的城市
        _totalCities = [NSMutableDictionary dictionary];
        //存放所有的城市组
        NSMutableArray *tempSections = [NSMutableArray array];
        //添加热门城市组
        CitySection *hotSection = [[CitySection alloc]init];
        hotSection.name = @"热门城市";
        hotSection.cities = [NSMutableArray array];
        [tempSections addObject:hotSection];
     
        
        //添加a-z组
        //加载plist数据
        NSArray *azArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Cities.plist" ofType:nil]];
        for (NSDictionary *azDict in azArray) {
            CitySection *section = [[CitySection alloc]init];
            [section setValues:azDict];
            [tempSections addObject:section];
            
            for (DPCity *city in section.cities) {
                if (city.hot) {
                    [hotSection.cities addObject:city];
                }
                [_totalCities setObject:city forKey:city.name];
            }
        }
        
        //从沙盒里面读取之前访问过的城市的名称
        _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        if (_visitedCityNames == nil) {
            _visitedCityNames = [NSMutableArray array];
        }
        
        //添加最近访问城市组
        CitySection *visitedSection = [[CitySection alloc]init];
        visitedSection.name = @"最近访问";
        visitedSection.cities = [NSMutableArray array];
        _visitedSection = visitedSection;
        
        for (NSString *name in _visitedCityNames) {
            DPCity *city = _totalCities[name];
            [visitedSection.cities addObject:city];
        }
        _totalCitySections = tempSections;
    }
    return self;
}

- (void)setCurrentCity:(DPCity *)currentCity
{
    _currentCity = currentCity;
    
    //移除之间的城市名
    [_visitedCityNames removeObject:currentCity.name];
    
    //将新的城市名放到最前面
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    //将新城市放到_visitedSection的最前面
    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];
    
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil];
    
    //添加最近访问城市
    if (![_totalCitySections containsObject:_visitedSection]) {
        NSMutableArray * allSections = (NSMutableArray *)_totalCitySections;
        [allSections insertObject:_visitedSection atIndex:0];
    }
}

@end
