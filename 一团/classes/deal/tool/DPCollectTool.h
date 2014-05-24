//
//  DPCollectTool.h
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class DPDeal;
@interface DPCollectTool : NSObject
singleton_interface(DPCollectTool)

//获取收藏的所有信息
@property(nonatomic,strong,readonly)NSArray *collectedDeals;

//处理团购是否收藏
-(void)handleDeal:(DPDeal *)deal;

//添加收藏
-(void)collectDeal:(DPDeal *)deal;

//取消收藏
-(void)uncollectDeal:(DPDeal *)deal;
@end
