//
//  DPDealBottomMenu.h
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPDealBottomMenu : UIView
{
    UIScrollView *_scrollView;
}
@property (nonatomic, copy) void (^hideBlock)();

// 通过动画显示出来
- (void)show;
// 通过动画隐藏
- (void)hide;
@end
