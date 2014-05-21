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
#import "DPMetaDataTool.h"
#import "DPSubtitlesView.h"

@interface DPDistrictMenu()
{
    NSMutableArray *_menuItems;
}

@end

@implementation DPDistrictMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _menuItems = [NSMutableArray array];
        
        // 获取当前选中的城市
        DPCity *city = [DPMetaDataTool sharedDPMetaDataTool].currentCity;
        
        //当前城市所有区域
        NSMutableArray *districts = [NSMutableArray array];
        //全部商业区域
        DPDistrict *all = [[DPDistrict alloc]init];
        all.name = KAllDistrict;
        [districts addObject:all];
        //其他商区
        [districts addObjectsFromArray:city.districts];
        int count = districts.count;
        for (int i = 0; i<count; i++) {
            // 创建区域item
            DPDistrictMenuItem *item = [[DPDistrictMenuItem alloc] init];
            item.district = districts[i];
            [item addTarget:self action:@selector(itemClickit:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
            
            //默认选中第0个item
            if (i == 0) {
                item.selected = YES;
                _selectedItem = item;
            }
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
        
        //监听城市改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChangeIt) name:kCityChangeNote object:nil];
    }
    return self;
}

-(void)cityChangeIt
{
    // 获取当前选中的城市
    DPCity *city = [DPMetaDataTool sharedDPMetaDataTool].currentCity;
    
    //当前城市所有区域
    NSMutableArray *districts = [NSMutableArray array];
    //全部商业区域
    DPDistrict *all = [[DPDistrict alloc]init];
    all.name = KAllDistrict;
    [districts addObject:all];
    //其他商区
    [districts addObjectsFromArray:city.districts];
    
    int count = districts.count;
    for (int i = 0; i<count; i++) {
        DPDistrictMenuItem *item = nil;
        
        if (i >= _menuItems.count) {
            item = [[DPDistrictMenuItem alloc]init];
            [item addTarget:self action:@selector(itemClickit:) forControlEvents:UIControlEventTouchUpInside];
            [_menuItems addObject:item];
            [_scrollView addSubview:item];
        } else {
            item = _menuItems[i];
        }
        
        item.hidden = NO;
        item.district = districts[i];
        item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
        
        //默认选中第0个item
        if (i == 0) {
            item.selected = YES;
            _selectedItem = item;
        } else {
            item.selected = NO;
        }
    }
    
    //隐藏多余item
    for (int i = 0; i<_menuItems.count; i++) {
        DPDistrictMenuItem *item = _scrollView.subviews[i];
        item.hidden = YES;
    }
    
    _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
    
    [_subtitlesView removeFromSuperview];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)subtitlesView:(DPSubtitlesView *)subtitlesView titleClick:(NSString *)title
{
    [DPMetaDataTool sharedDPMetaDataTool].currentDistrict = title;
}

-(NSString *)subtitlesViewGetCurrentTitle:(DPSubtitlesView *)subtitlesView
{
    return [DPMetaDataTool sharedDPMetaDataTool].currentDistrict;
}

//-(void)settingSubtitlesViews
//{
//    _subtitlesView.setTitleBlock = ^(NSString *title){
//        [DPMetaDataTool sharedDPMetaDataTool].currentDistrict = title;
//    };
//    _subtitlesView.getTitleBlock = ^{
//        return [DPMetaDataTool sharedDPMetaDataTool].currentDistrict;
//    };
//}

@end
