//
//  DPRestrictions.h
//  一团
//
//  Created by DP on 14-5-23.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPRestrictions : NSObject
@property (nonatomic,assign) BOOL is_reservation_required;
@property (nonatomic,assign) BOOL  is_refundable;
@property (nonatomic,copy) NSString *special_tips;
@end
