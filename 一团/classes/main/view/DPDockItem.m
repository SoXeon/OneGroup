//
//  DPDockItem.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDockItem.h"

@implementation DPDockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *divider = [[UIImageView alloc] init];
        divider.frame = CGRectMake(0, 0, kDockItemW, 2);
        divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
        [self addSubview:divider];
        _divider = divider;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame.size = CGSizeMake(kDockItemW, kDockItemH);
    [super setFrame:frame];
}

#pragma mark 重写高亮状态
- (void)setHighlighted:(BOOL)highlighted { }

#pragma mark 设置按钮内部图片
-(void)setIcon:(NSString *)icon
{
    _icon = icon;
    [self setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)setSelectedIcon:(NSString *)selectedIcon
{
    _selectedIcon = selectedIcon;
    [self setImage:[UIImage imageNamed:selectedIcon] forState:UIControlStateDisabled];
}

- (void)setIcon:(NSString *)icon selectedIcon:(NSString *)selectedIcon
{
    self.icon = icon;
    self.selectedIcon = selectedIcon;
}

@end
