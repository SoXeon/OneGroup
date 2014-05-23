//
//  DPCollectViewController.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPCollectViewController.h"
#import "DPDealDetailController.h"
#import "DPNavigationController.h"

#import "DPDealTopMenu.h"
#import "DPAPI.h"
#import "DPMetaDataTool.h"
#import "DPCity.h"
#import "DPDeal.h"
#import "DPDealCell.h"
#import "NSObject+Value.h"
#import "DPDealTool.h"
#import "MJRefresh.h"
#import "DPImageTool.h"
#import "UIBarButtonItem+DP.h"


#import "DPCover.h"
#define kDetailWitdh 600


@interface DPCollectViewController ()

{
    NSMutableArray *_deals;
    int _page;//页码
    MJRefreshFooterView *_footer;//下拉加载更多
    MJRefreshHeaderView *_header;
    
    DPCover *_cover;
}


@end

@implementation DPCollectViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"收藏";
    
    [self showDetail:_deals[10]];
}

#pragma mark 显示详情控制器
-(void)showDetail:(DPDeal *)deal
{
//    if (_cover == nil) {
//        _cover = [DPCover coverWithTarget:self action:@selector(hideDetail)];}
//    _cover.frame = self.navigationController.view.bounds;
//    _cover.alpha = 0;
//    [UIView animateWithDuration:0.4 animations:^{
//        [_cover reset];
//    }];
//    [self.navigationController.view addSubview:_cover];
    
    //展示团购详情
    DPDealDetailController *detail = [[DPDealDetailController alloc]init];
    detail.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"btn_nac_close.png" highlightedIcon:@"btn_nav_close_hl.png" target:self action:@selector(hideDetail)];
    detail.deal = deal;
    DPNavigationController *nav = [[DPNavigationController alloc]initWithRootViewController:detail];
    nav.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
    nav.view.frame = CGRectMake(_cover.frame.size.width, 0, 600, _cover.frame.size.height);
    //两个控制器为互为父子关系，view也是一样的
    [self.navigationController.view addSubview:nav.view];
    [self.navigationController addChildViewController:nav];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = nav.view.frame;
        f.origin.x -= kDetailWitdh;
        nav.view.frame = f;
    }];
}

-(void)hideDetail
{
    //隐藏遮盖
    UIViewController *nav = [self.navigationController.childViewControllers lastObject];
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0;
        CGRect f = nav.view.frame;
        f.origin.x += kDetailWitdh;
        nav.view.frame = f;
    } completion:^(BOOL finished) {
        [_cover removeFromSuperview];
        [nav.view removeFromSuperview];
        [nav removeFromParentViewController];
    }];
}

@end
