//
//  DPCity.h
//  一团
//
//  Created by DP on 14-5-13.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPBaseModel.h"

@interface DPCity : DPBaseModel
@property (nonatomic,strong) NSArray *districts;//分区
@property (nonatomic,assign) BOOL hot;//热度
@end
