//
//  DPCategoryMenu.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPCategoryMenu.h"
#import "DPMetaDataTool.h"
#import "DPCategoryMenuItem.h"
#import "DPCategory.h"

#import "DPSubtitlesView.h"

@interface DPCategoryMenu()
@end

@implementation DPCategoryMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *categories = [DPMetaDataTool sharedDPMetaDataTool].totalCategories;
        
        //往scrollView中添加内容
        int count = categories.count;
        for (int i = 0; i<count; i++) {            
            //创建item
            DPCategoryMenuItem *item = [[DPCategoryMenuItem alloc]init];
            item.category = categories[i];
            [item addTarget:self action:@selector(itemClickit:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    }
    return self;
}



@end
