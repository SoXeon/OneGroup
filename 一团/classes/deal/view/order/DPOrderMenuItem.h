//
//  DPOrderMenuItem.h
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealBottomMenuItem.h"
@class DPOrder;
@interface DPOrderMenuItem : DPDealBottomMenuItem
@property (nonatomic,strong) DPOrder *order;
@end
