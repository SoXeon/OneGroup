//
//  DPDealBottomMenu.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealBottomMenu.h"
#import "DPSubtitlesView.h"
#import "DPDealBottomMenuItem.h"
#import "DPMetaDataTool.h"

#import "DPCategoryMenuItem.h"
#import "DPDistrictMenuItem.h"
#import "DPOrderMenuItem.h"

#define kCoverAlpha 0.4

@interface DPDealBottomMenu()
{
    UIView *_cover;
        
    UIView *_contentView;
}
@end

@implementation DPDealBottomMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        //添加蒙板
        UIView *cover = [[UIView alloc]init];
        cover.alpha = kCoverAlpha;
        cover.frame = self.bounds;
        cover.autoresizingMask = self.autoresizingMask;
        cover.backgroundColor = [UIColor blackColor];
        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)]];
        [self addSubview:cover];
        _cover = cover;
        
        // 内容view
        _contentView = [[UIView alloc] init];
        _contentView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemH);
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_contentView];
        
        //添加scrollView
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        scrollView.frame = CGRectMake(0, 0, self.frame.size.width, kBottomMenuItemH);
        scrollView.backgroundColor =[UIColor whiteColor];
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return self;
}

- (void)itemClickit:(DPDealBottomMenuItem *)item
{
    // 1.控制item的状态
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    
    // 2.查看是否有子分类
    if (item.titles.count) { // 显示所有的子标题
        [self showSubitlesView:item];
    } else { // 隐藏所有的子标题
        [self hideSubitlesView:item];
    }
    
}

#pragma mark隐藏子标题
- (void)hideSubitlesView:(DPDealBottomMenuItem *)item
{
    [_subtitlesView hide];
    
    //调整整个内容view的frame
    CGRect f = _contentView.frame;
    f.size.height = kBottomMenuItemH;
    _contentView.frame = f;
    
    //设置当前数据
    NSString *title = [item titleForState:UIControlStateNormal];
    if ([item isKindOfClass:[DPCategoryMenuItem class]]) {
        [DPMetaDataTool sharedDPMetaDataTool].currentCategory = title;
    } else if ([item isKindOfClass:[DPDistrictMenuItem class]]) {
        [DPMetaDataTool sharedDPMetaDataTool].currentDistrict = title;
    } else {
        [DPMetaDataTool sharedDPMetaDataTool].currentOrder = [[DPMetaDataTool sharedDPMetaDataTool] orderWithName:title];
    }
}

#pragma mark 显示子标题
- (void)showSubitlesView:(DPDealBottomMenuItem *)item
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:kDefaultAnimDuration];
    
    if (_subtitlesView == nil) {
        _subtitlesView = [[DPSubtitlesView alloc] init];
        _subtitlesView.delegate = self;
//        [self settingSubtitlesViews];
    }
    
    //设置子标题的frame
    _subtitlesView.frame = CGRectMake(0, kBottomMenuItemH, self.frame.size.width, _subtitlesView.frame.size.height);
    //设置子标题的主标题
    _subtitlesView.mainTitle = [item titleForState:UIControlStateNormal];
    //设置子标题显示内容
    _subtitlesView.titles = item.titles;

    if (_subtitlesView.superview == nil) { // 没有父控件
        [_subtitlesView show];
    }
    //添加子标题需要显示的内容scrollView底部
    [_contentView insertSubview:_subtitlesView belowSubview:_scrollView];
    
    //调整整个内容view的frame
    CGRect f = _contentView.frame;
    f.size.height = kBottomMenuItemH + _subtitlesView.frame.size.height;
    _contentView.frame = f;
    
    [UIView commitAnimations];
}

#pragma mark 显示
- (void)show
{
    _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
    _contentView.alpha = 0;
    _cover.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        // 1.scrollView从上面 -> 下面
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha = 1;
        // 2.遮盖（0 -> 0.4）
        _cover.alpha = kCoverAlpha;
    }];
}

- (void)hide
{
    if (_hideBlock) {
        _hideBlock();
    }
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        // 1.scrollView从下面 -> 上面
        _contentView.transform = CGAffineTransformMakeTranslation(0, -_contentView.frame.size.height);
        
        _contentView.alpha = 0;
        
        // 2.遮盖（0.4 -> 0）
        _cover.alpha = 0;
    } completion:^(BOOL finished) {
        // 从父控件中移除
        [self removeFromSuperview];
        
        // 恢复属性
        _contentView.transform = CGAffineTransformIdentity;
        _contentView.alpha  = 1;
        _cover.alpha = kCoverAlpha;
    }];
}

@end
