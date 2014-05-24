//
//  DPDealTool.h
//  一团
//
//  Created by DP on 14-5-20.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <MapKit/MapKit.h>

@class DPDeal;

typedef void (^DealsSuccessBlock)(NSArray *deals,int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);

typedef void (^DealSuccessBlock)(DPDeal *deal);
typedef void (^DealErrorBlock)(NSError *error);


@interface DPDealTool : NSObject
singleton_interface(DPDealTool)
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;


#pragma mark 获取指定团购详情数据
-(void)dealWithID:(NSString *)ID success:(DealSuccessBlock)success error:(DealErrorBlock)error;

#pragma mark 获得周边团购信息
-(void)dealsWithPos:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;


@end
