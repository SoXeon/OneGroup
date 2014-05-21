//
//  DPDealTool.h
//  一团
//
//  Created by DP on 14-5-20.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef void (^DealsSuccessBlock)(NSArray *deals,int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);


@interface DPDealTool : NSObject
singleton_interface(DPDealTool)
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

@end
