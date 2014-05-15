//
//  DPDistrictMenu.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDistrictMenu.h"
#import "DPDistrictMenuItem.h"
#import "DPMetaDataTool.h"
#import "DPCity.h"
#import "DPDistrict.h"
#import "DPDealBottomMenu.h"
#import "DPSubtitlesView.h"
#import "DPDealBottomMenuItem.h"

@implementation DPDistrictMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.往scrollView中添加内容
        
        // 获取当前选中的城市
        DPCity *city = [DPMetaDataTool sharedDPMetaDataTool].currentCity;
        int count = city.districts.count;
        
        for (int i = 0; i<count; i++) {
            // 创建区域item
            DPDistrictMenuItem *item = [[DPDistrictMenuItem alloc] init];
            item.district = city.districts[i];
            [item addTarget:self action:@selector(itemClickit:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}

@end
