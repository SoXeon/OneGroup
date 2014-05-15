//
//  DPCategory.h
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPBaseModel.h"

@interface DPCategory : DPBaseModel
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,strong) NSArray *subcategories;
@end
