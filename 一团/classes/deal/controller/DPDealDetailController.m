//
//  DPDealDetailController.m
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealDetailController.h"
#import "DPDeal.h"
#import "UIBarButtonItem+DP.h"
#import "DPBuyDock.h"
#import "DPDetailDock.h"
#import "DPDealInfoController.h"
#import "DPDealWebController.h"
#import "DPMerchantController.h"
#import "DPCollectTool.h"


@interface DPDealDetailController () <DPDetailDockDelegate>
{
    DPDetailDock *_detailDock;
}
@end

@implementation DPDealDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self baseSetting];
    
    [self addBuyDock];
    
    [self addDetailDock];
    
    [self addAllChildControllers];
}

#pragma mark 初始化自控制器
-(void)addAllChildControllers
{
    //团购简介
    DPDealInfoController *info = [[DPDealInfoController alloc]init];
    info.deal = _deal;
    [self addChildViewController:info];
    //默认选中第0个控制器
    [self detailDock:nil btnClickFrom:0 to:0];
    
    //图文详情
    DPDealWebController *web = [[DPDealWebController alloc]init];
    web.deal = _deal;
    web.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:web];
    
    //商家详情
    DPMerchantController *merchant = [[DPMerchantController alloc]init];
    merchant.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:merchant];
}

#pragma mark dock的代理方式
-(void)detailDock:(DPDetailDock *)detailDock btnClickFrom:(int)from to:(int)to
{
    //移除旧控制器的view
    UIViewController *old = self.childViewControllers[from];
    [old.view removeFromSuperview];
    
    //添加新控制器的view
    UIViewController *new = self.childViewControllers[to];
    new.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    CGFloat w = self.view.frame.size.width - _detailDock.frame.size.width;
    CGFloat h = self.view.frame.size.height;
    new.view.frame = CGRectMake(0, 0, w, h);
    [self.view insertSubview:new.view atIndex:0];
}

#pragma mark 添加右边的选项卡栏
-(void)addDetailDock
{
    DPDetailDock *dock = [DPDetailDock detailDock];
    CGSize size = dock.frame.size;
    CGFloat x = self.view.frame.size.width - size.width;
    CGFloat y = self.view.frame.size.height - size.height - 100;
    dock.frame = CGRectMake( x, y, 0, 0);
    dock.delegate = self;
    [self.view addSubview:dock];
    _detailDock = dock;
}

#pragma mark 添加顶部购买栏
-(void)addBuyDock
{
    DPBuyDock *dock = [DPBuyDock buyDock];
    dock.deal = _deal;
    dock.frame = CGRectMake(0, 0, self.view.frame.size.width, 60);
    [self.view addSubview:dock];
}

-(void)baseSetting
{
    //背景色
    self.view.backgroundColor = kGlobalBg;
    
    //设置标题
    self.title = _deal.title;
    
    //处理团购的收藏属性
    [[DPCollectTool sharedDPCollectTool] handleDeal:_deal];
    
    NSString *collectIcon = _deal.collected ? @"ic_collect_suc.png" : @"ic_deal_collect.png";
    
    //设置导航
    self.navigationItem.rightBarButtonItems = @[
    [UIBarButtonItem itemWithIcon:@"btn_share.png" highlightedIcon:@"btn_share_pressed.png" target:nil action:nil],
    [UIBarButtonItem itemWithIcon:collectIcon highlightedIcon:@"ic_deal_collect_pressed.png" target:self action:@selector(collect)]];
}

-(void)collect
{
    UIButton *btn = (UIButton *)[self.navigationItem.rightBarButtonItems[1] customView];
    if (_deal.collected) {
        [[DPCollectTool sharedDPCollectTool] uncollectDeal:_deal];
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_deal_collect.png"] forState:UIControlStateNormal];
    } else {
        [[DPCollectTool sharedDPCollectTool] collectDeal:_deal];
        [btn setBackgroundImage:[UIImage imageNamed:@"ic_collect_suc.png"] forState:UIControlStateNormal];
    }
}

@end
