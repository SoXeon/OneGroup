//
//  DPBusiness.h
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPBusiness : NSObject

@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *h5_url;
@property(nonatomic,assign) int *ID;
@property(nonatomic,assign) double latitude;
@property(nonatomic,assign) double longitude;
@property(nonatomic,copy)NSString *name;

@end
