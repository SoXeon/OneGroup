//
//  DPDealBottomMenu.h
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPSubtitlesView.h"

@class DPDealBottomMenuItem,DPSubtitlesView;
@protocol DPSubtitlesViewDelegate;

@interface DPDealBottomMenu : UIView <DPSubtitlesViewDelegate>
{
    UIScrollView *_scrollView;
    DPSubtitlesView *_subtitlesView;
    DPDealBottomMenuItem *_selectedItem;
}
@property (nonatomic, copy) void (^hideBlock)();

//- (void)settingSubtitlesViews;

// 通过动画显示出来
- (void)show;
// 通过动画隐藏
- (void)hide;
- (void)itemClickit:(DPDealBottomMenuItem *)item;
@end
