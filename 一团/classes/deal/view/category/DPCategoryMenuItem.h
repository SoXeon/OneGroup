//
//  DPCategoryMenuItem.h
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealBottomMenuItem.h"
@class DPCategory;
@interface DPCategoryMenuItem : DPDealBottomMenuItem
//需要显示的分类数据
@property (nonatomic,strong) DPCategory *category;
@end
