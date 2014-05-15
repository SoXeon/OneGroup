//
//  DPDealTopMenu.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealTopMenu.h"
#import "DPDealTopMenuItem.h"
#import "DPCategoryMenu.h"
#import "DPDistrictMenu.h"
#import "DPOrderMenu.h"

@interface DPDealTopMenu()
{
    DPDealTopMenuItem *_selectedItem;
    
    DPCategoryMenu *_cMenu;//分类菜单
    
    DPDistrictMenu *_dMenu;//分区菜单
    
    DPOrderMenu *_oMenu;//排序菜单
    
    DPDealBottomMenu *_showingMenu;//正在展示的的底部菜单
}

@end

@implementation DPDealTopMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.全部分类
        [self addMenuItem:@"全部分类" index:0];
        
        //2.全部分区
        [self addMenuItem:@"全部分区" index:1];
        
        //3.默认排序
        [self addMenuItem:@"默认排序" index:2];
    }
    return self;
}

#pragma mark 添加item
- (void)addMenuItem:(NSString *)title index:(int)index
{
    DPDealTopMenuItem * item = [[DPDealTopMenuItem alloc]init];
    item.title = title;
    item.tag = index;
    item.frame = CGRectMake(kTopMenuItemW * index, 0, 0, 0);
    [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:item];
}

#pragma mark 监听顶部item的点击
- (void)itemClick:(DPDealTopMenuItem *)item
{
    //控制选中状态
    _selectedItem.selected = NO;
    if (_selectedItem == item) {
        _selectedItem = nil;
        //隐藏底部菜单
        [self hideBottomMenu];
    } else {
        item.enabled = YES;
        _selectedItem = item;
        //显示底部菜单
        [self showBottomMenu:item];
    }
}

#pragma mark 隐藏底部菜单
- (void)hideBottomMenu
{
    [_showingMenu hide];
    _showingMenu = nil;
}


#pragma mark 显示底部菜单
- (void)showBottomMenu:(DPDealTopMenuItem *)item
{
    //是否需要执行动画
    BOOL animted = _showingMenu == nil;
    
    //移除当前正在显示的菜单
    [_showingMenu removeFromSuperview];
    
    //显示底部菜单
    if (item.tag == 0) {
        if (_cMenu == nil) {
            _cMenu = [[DPCategoryMenu alloc]init];
        }
        _showingMenu = _cMenu;
    } else if (item.tag == 1) {
        if (_dMenu == nil) {
            _dMenu = [[DPDistrictMenu alloc]init];
        }
        _showingMenu = _dMenu;
    } else {
        if (_oMenu == nil) {
            _oMenu = [[DPOrderMenu alloc]init];
        }
        _showingMenu = _oMenu;
    }
    //设置frame
    _showingMenu.frame = _contentView.bounds;
    
    //设置block回调
    __unsafe_unretained DPDealTopMenu *menu = self;
    _showingMenu.hideBlock = ^ {
        //取消当前选中的item
        menu->_selectedItem.selected = NO;
        menu->_selectedItem = nil;
        
        //清空正在显示的菜单
        menu->_showingMenu = nil;
    };
    
    //添加即将要显示的菜单
    [_contentView addSubview:_showingMenu];
    
    //执行菜单出现的动画
    if (animted) {
        [_showingMenu show];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(3 * kTopMenuItemW, kTopMenuItemH);
    [super setFrame:frame];
}
@end