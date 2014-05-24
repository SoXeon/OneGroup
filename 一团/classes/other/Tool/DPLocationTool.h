//
//  DPLocationTool.h
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@class DPCity;
@interface DPLocationTool : NSObject
singleton_interface(DPLocationTool)
@property (nonatomic,strong) DPCity *locationCity; //定位城市
@end
