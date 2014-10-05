//
//  DPLocationTool.m
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPLocationTool.h"
#import <CoreLocation/CoreLocation.h>
#import "DPMetaDataTool.h"
#import "DPCity.h"

@interface DPLocationTool() <CLLocationManagerDelegate>
{
    CLLocationManager *_mgr;
    CLGeocoder *_geo;
}

@end

@implementation DPLocationTool
singleton_implementation(DPLocationTool)

-(id)init
{
    if (self = [super init]) {
        _geo = [[CLGeocoder alloc]init];
        
        _mgr = [[CLLocationManager alloc]init];
        _mgr.delegate = self;
        [_mgr startUpdatingLocation];
    }
    return self;
}

#warning  这里有个小问题，就是string必须是汉字，然后我设置了模拟器是中文才行，外国的就是拼音了,发给大众点评的数据就不对了，然后设置了当前城市也不对了，就没有办法返回真确数据了

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //停止定位
    [_mgr stopUpdatingLocation];
    
    CLLocation *loc = locations[0];
    [_geo reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
       CLPlacemark *place = placemarks[0];
        NSString *cityName = place.administrativeArea;
        cityName = [cityName substringToIndex:cityName.length -1 ];
        DPCity *city = [DPMetaDataTool sharedDPMetaDataTool].totalCities[cityName];
        [DPMetaDataTool sharedDPMetaDataTool].currentCity = city;
        
        _locationCity = city;
        _locationCity.position = loc.coordinate;
    }];
}
@end
