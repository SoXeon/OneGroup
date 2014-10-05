//
//  DPCollectTool.m
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPCollectTool.h"
#import "DPDeal.h"

#define  kFilePath  [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"collects.data"]

@interface DPCollectTool()
{
    NSMutableArray *_collectedDeals;
}

@end

@implementation DPCollectTool
singleton_implementation(DPCollectTool)

-(id)init
{
    if (self = [super init]) {
        
        _collectedDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    
        if (_collectedDeals == nil) {
            _collectedDeals = [NSMutableArray array];
        }
    }
    return self;
}

-(void)collectDeal:(DPDeal *)deal
{
    deal.collected = YES;
    [_collectedDeals insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}

-(void)uncollectDeal:(DPDeal *)deal
{
    deal.collected = NO;
    [_collectedDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}

-(void)handleDeal:(DPDeal *)deal
{
    deal.collected = [_collectedDeals containsObject:deal];
}

@end
