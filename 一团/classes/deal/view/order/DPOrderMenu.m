//
//  DPOrderMenu.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPOrderMenu.h"
#import "DPMetaDataTool.h"
#import "DPOrderMenuItem.h"
#import "DPOrder.h"

@implementation DPOrderMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *orders = [DPMetaDataTool sharedDPMetaDataTool].totalOrders;
        
        //往scrollView中添加内容
        int count = orders.count;
        for (int i = 0; i<count; i++) {
            //创建item
            DPOrderMenuItem *item = [[DPOrderMenuItem alloc]init];
            item.order = orders[i];
            [item addTarget:self action:@selector(itemClickit:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}
@end
