//
//  DPDock.m
//  一团
//
//  Created by 戴鹏 on 14-5-11.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//



#import "DPDock.h"
#import "DPMoreItem.h"
#import "DPLocationItem.h"
#import "DPTabItem.h"


@interface DPDock()
{
    DPTabItem *_selectedItem;//被选中的标签
}
@end

@implementation DPDock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //自动伸缩，针对高度,右边间距
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        
        //设置背景颜色,这里可以平铺，填充背景
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_tabbar.png"]];
        
        //添加LOGO
        [self addLogo];
        
        //添加选项标签
        [self addTabs];
        
        //添加定位
        [self addLocation];
        
        //添加更多
        [self addMore];
    }
    return self;
}

#pragma mark 重写setFrame方法，定死自己定宽度
- (void)setFrame:(CGRect)frame
{
    frame.size.width = kDockItemW;
    [super setFrame:frame];
}

#pragma mark 添加Logo
-(void)addLogo
{
    UIImageView *logo = [[UIImageView alloc]init];
    logo.image =[UIImage imageNamed:@"ic_logo.png"];
    //设置尺寸
    CGFloat scale = 0.6;
    CGFloat logoW = logo.image.size.width * scale;
    CGFloat logoH = logo.image.size.height * scale;
    logo.bounds = CGRectMake(0, 0, logoW, logoH);
    //设置位置
    logo.center = CGPointMake(kDockItemW * 0.5, kDockItemH * 0.5);
    [self addSubview:logo];
}

#pragma mark 添加Tabs
- (void)addTabs
{
    //团购
    [self addOneTab:@"ic_deal.png" selectedIcon:@"ic_deal_hl.png" index:1];
    
    //地图
    [self addOneTab:@"ic_map.png" selectedIcon:@"ic_map_hl.png" index:2];

    //收藏
    [self addOneTab:@"ic_collect.png" selectedIcon:@"ic_collect_hl.png" index:3];

    //我的
    [self addOneTab:@"ic_mine.png" selectedIcon:@"ic_mine_hl.png" index:4];
    
    //添加底部分割线
    UIImageView *divider = [[UIImageView alloc] init];
    divider.frame = CGRectMake(0, kDockItemH * 5, kDockItemW, 2);
    divider.image = [UIImage imageNamed:@"separator_tabbar_item.png"];
    [self addSubview:divider];

}

#pragma mark 添加一个标签
-(void)addOneTab:(NSString *)icon  selectedIcon:(NSString *)selectedIcon index:(int)index
{
    DPTabItem *tab = [[DPTabItem alloc]init];
    [tab setIcon:icon selectedIcon:selectedIcon];
    tab.frame = CGRectMake(0, kDockItemH * index, 0, 0);
    [tab addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchDown];
    tab.tag = index - 1;
    [self addSubview:tab];
    
    if (index == 1) {
        [self tabClick:tab];
    }
}

#pragma mark 监听tab点击
- (void)tabClick:(DPTabItem *)tab
{
    //通知代理
    if ([_delegate respondsToSelector:@selector(dock:tabChangeFrom:to:)]) {
        [_delegate dock:self tabChangeFrom:_selectedItem.tag to:tab.tag];
    }
    
    //控制状态
    _selectedItem.enabled = YES;
    tab.enabled = NO;
    _selectedItem = tab;
    
}

#pragma mark 添加Location
- (void)addLocation
{
    DPLocationItem *loc = [[DPLocationItem alloc]init];
    CGFloat y = self.frame.size.height - kDockItemH * 2;
    loc.frame = CGRectMake(0, y, 0, 0);
    [self addSubview:loc];
}

#pragma mark 添加更多
- (void)addMore
{
    DPMoreItem *more = [[DPMoreItem alloc]init];
    CGFloat y = self.frame.size.height - kDockItemH;
    more.frame = CGRectMake(0, y, 0, 0);
    [self addSubview:more];
}

@end
