//
//  DPDealTopMenuItem.m
//  一团
//
//  Created by DP on 14-5-15.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#define kTitkeScale 0.8

#import "DPDealTopMenuItem.h"
#import "UIImage+DP.h"

@implementation DPDealTopMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        //设置箭头，设置居中缩小
        [self setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //添加分割线
        UIImage *img = [UIImage imageNamed:@"separator_topbar_item.png"];
        UIImageView *divider = [[UIImageView alloc]initWithImage:img];
        divider.bounds = CGRectMake(0, 0, 2, kTopMenuItemH * 0.7);
        divider.center = CGPointMake(kTopMenuItemW, kTopMenuItemH * 0.5);
        [self addSubview:divider];
        
        //设置选中时的背景
        [self setBackgroundImage:[UIImage resizedImage:@"slider_filter_bg_normal.png"] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kTopMenuItemW, kTopMenuItemH);
    [super setFrame:frame];
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat w = contentRect.size.width *kTitkeScale;
    return CGRectMake(0, 0, w, h);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat h = contentRect.size.height;
    CGFloat x = contentRect.size.width *kTitkeScale;
    CGFloat w = contentRect.size.width - x;
    return CGRectMake(x, 0, w, h);
}
@end
