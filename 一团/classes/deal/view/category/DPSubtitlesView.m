//
//  DPSubtitlesView.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPSubtitlesView.h"
#import "UIImage+DP.h"
#import "DPMetaDataTool.h"

#define kTitleW 100
#define kTitleH 40

@interface DPSubtitlesView()
{
    UIButton *_selectedBtn;
}

@end

@implementation DPSubtitlesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.image = [UIImage resizedImage:@"bg_subfilter_other.png"];
        //裁剪超出父控件的子控件
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}

#pragma mark 监听小按钮的点击
- (void)titleClick:(UIButton *)btn
{
    //控制按钮状态
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    //设置当前选中的分类文字
//    if (_setTitleBlock) {
//        _setTitleBlock([btn titleForState:UIControlStateNormal]);
//    }
    if ([_delegate respondsToSelector:@selector(subtitlesView:titleClick:)]) {
        [_delegate subtitlesView:self titleClick:[btn titleForState:UIControlStateNormal]];
    }
    
    
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
            [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_active.png"] forState:UIControlStateSelected];
            [self addSubview:btn];
        } else {
            btn = self.subviews[i];
        }
        
        // 2.设置按钮文字
        btn.hidden = NO;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        
        //3.根据按钮文字来设定是否被选中
        if ([_delegate respondsToSelector:@selector(subtitlesViewGetCurrentTitle:)]) {
            NSString *current =  [_delegate subtitlesViewGetCurrentTitle:self];
            btn.selected = [titles[i] isEqualToString:current];
            if (btn.selected) {
                _selectedBtn = btn;
            }
        } else {
                btn.selected = NO;
            }
        
//        if (_getTitleBlock) {
//            NSString *current = _getTitleBlock();
//            btn.selected = [titles[i] isEqualToString:current];
//        } else {
//            btn.selected = NO;
//        }
    }
    
    // 隐藏后面多余的按钮
    for (int i = count; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.hidden = YES;
    }
    [self layoutSubviews];
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
    
        int rows = (_titles.count + columns - 1) / columns;
        CGRect frame = self.frame;
        frame.size.height = rows * kTitleH;
        self.frame = frame;
}

- (void)show
{
    [self layoutSubviews];
    
    self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
    self.alpha = 0;
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:kDefaultAnimDuration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        CGRect f = self.frame;
        f.size.height = 0;
        self.frame = f;
        
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}


@end
