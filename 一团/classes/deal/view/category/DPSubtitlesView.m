//
//  DPSubtitlesView.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPSubtitlesView.h"
#import "UIImage+DP.h"

#define kTitleW 100
#define kTitleH 40

#define kDuration 1.0

@implementation DPSubtitlesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.image = [UIImage resizedImage:@"bg_subfilter_other.png"];
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    int count = titles.count;
    // 设置按钮的文字
    for (int i = 0; i<count; i++) {
        // 1.取出i位置对应的按钮
        UIButton *btn = nil;
        if (i >= self.subviews.count) { // 按钮个数不够
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:btn];
        } else {
            btn = self.subviews[i];
        }
        
        // 2.设置按钮文字
        btn.hidden = NO;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
    }
    
    // 隐藏后面多余的按钮
    for (int i = count; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.hidden = YES;
    }
}

// 控件本身的宽高发生改变的时候就会调用
- (void)layoutSubviews
{
    // 一定要调用super
    [super layoutSubviews];
    
    int columns = self.frame.size.width / kTitleW;
    for (int i = 0; i<_titles.count; i++) {
        UIButton *btn = self.subviews[i];
        
        // 设置位置
        CGFloat x = i % columns * kTitleW;
        CGFloat y = i / columns * kTitleH;
        btn.frame = CGRectMake(x, y, kTitleW, kTitleH);
    }
    
    //    [UIView animateWithDuration:1.0 animations:^{
    int rows = (_titles.count + columns - 1) / columns;
    CGRect frame = self.frame;
    frame.size.height = rows * kTitleH;
    self.frame = frame;
    //    }];
}

- (void)show
{
    [self layoutSubviews];
    
    self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:kDuration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

@end
