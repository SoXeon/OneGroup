//
//  DPDealPosAnnotation.m
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealPosAnnotation.h"
#import "DPMetaDataTool.h"
#import "DPDeal.h"

@implementation DPDealPosAnnotation
-(void)setDeal:(DPDeal *)deal
{
    _deal = deal;
    
    for (NSString *c in deal.categories) {
        NSString *icon = [[DPMetaDataTool sharedDPMetaDataTool] iconWithCategoryName:c];
        
        if (icon) {
            _icon = [icon stringByReplacingOccurrencesOfString:@"filter_" withString:@""];            
            break;
        }
    }
}
@end
