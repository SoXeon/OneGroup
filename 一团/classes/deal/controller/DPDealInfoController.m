//
//  DPDealInfoController.m
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealInfoController.h"
#import "DPInfoHeaderView.h"
#import "DPDealTool.h"
#import "DPDeal.h"

@interface DPDealInfoController ()
{
    UIScrollView *_scrollView;
    DPInfoHeaderView *_header;
}

@end

@implementation DPDealInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addScrollView];
    
    [self addHeaderView];
    
//    [self performSelector:@selector(loadDetailDeal) withObject:nil afterDelay:0];
    [self loadDetailDeal];
}

#pragma mark 添加更多详情团购信息
-(void)loadDetailDeal
{
    [[DPDealTool sharedDPDealTool]dealWithID:_deal.deal_id success:^(DPDeal *deal) {
        _header.deal = deal;
    } error:^(NSError *error) {
        
    }];
}

#pragma mark 添加头部空间
-(void)addHeaderView
{
    DPInfoHeaderView *header = [DPInfoHeaderView infoHeaderView];
    header.frame = CGRectMake(0, 0, _scrollView.frame.size.width ,0 );
    header.deal = _deal;
    [_scrollView addSubview:header];
    _header = header;
}

#pragma mark 添加scrollView
-(void)addScrollView
{
    //添加滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.bounds = CGRectMake(0, 0, 430, self.view.frame.size.height);
    CGFloat x = self.view.frame.size.width * 0.5;
    CGFloat y = self.view.frame.size.height * 0.5;
    scrollView.center = CGPointMake(x, y);
    scrollView.backgroundColor = [UIColor yellowColor];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:scrollView];
    
    CGFloat height = 70;
    scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    scrollView.contentOffset = CGPointMake(0, -height);
    
    _scrollView = scrollView;
}


@end
