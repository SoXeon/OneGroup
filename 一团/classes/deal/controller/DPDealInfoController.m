//
//  DPDealInfoController.m
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealInfoController.h"
#import "DPInfoHeaderView.h"
#import "DPInfoTextView.h"
#import "DPRestrictions.h"
#import "DPDealTool.h"
#import "DPDeal.h"

#define kVMargin 15

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
    
    [self loadDetailDeal];
}

#pragma mark 添加更多详情团购信息
-(void)loadDetailDeal
{
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin;
    indicator.center = CGPointMake(_scrollView.frame.size.width * 0.5,CGRectGetMaxY(_header.frame) +kVMargin);
    [_scrollView addSubview:indicator];
    [indicator startAnimating];
    
    [[DPDealTool sharedDPDealTool]dealWithID:_deal.deal_id success:^(DPDeal *deal) {
        _deal = deal;
        _header.deal = deal;
        
        //添加详情数据
        [self addDetailViews];
        
        //移除菊花
        [indicator removeFromSuperview];
    } error:^(NSError *error) {
        
    }];
}

#pragma mark 添加详情控件
-(void)addDetailViews
{
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_header.frame) +kVMargin);
    
    //团购详情
    [self addTextView:@"ic_content.png" title:@"团购详情" content:_deal.details];
    
    //购买须知
    [self addTextView:@"ic_tip.png" title:@"购买须知" content:_deal.restrictions.special_tips];

    //重要通知
    [self addTextView:@"ic_tip.png" title:@"重要通知" content:_deal.notice];

}

#pragma mark 添加一个DPInfoTextView
-(void)addTextView:(NSString *)icon title:(NSString *)title content:(NSString *)content
{
    if (content.length == 0) {
        return;
    }
    
    DPInfoTextView *textView = [DPInfoTextView infoTextView];

    CGFloat y = _scrollView.contentSize.height;
    CGFloat w = _scrollView.frame.size.width;
    CGFloat h = textView.frame.size.height;
    textView.frame = CGRectMake(0, y,w, h);
    
    textView.title = title;
    textView.content = content;
    textView.icon = icon;
    
    [_scrollView addSubview:textView];
    
    //设置内容尺寸
    _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(textView.frame) + kVMargin);

}

#pragma mark 添加头部空间
-(void)addHeaderView
{
    DPInfoHeaderView *header = [DPInfoHeaderView infoHeaderView];
    header.frame = CGRectMake(0, 0, _scrollView.frame.size.width ,header.frame.size.height);
    header.deal = _deal;
    [_scrollView addSubview:header];
    _header = header;
}

#pragma mark 添加scrollView
-(void)addScrollView
{
    //添加滚动视图，使得视图下移
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.bounds = CGRectMake(0, 0, 620, self.view.frame.size.height);
    scrollView.showsVerticalScrollIndicator = NO;
    CGFloat x = self.view.frame.size.width * 0.5;
    CGFloat y = self.view.frame.size.height * 0.5;
    scrollView.center = CGPointMake(x, y);
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:scrollView];
    
    CGFloat height = 70;
    scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    scrollView.contentOffset = CGPointMake(0, -height);
    
    _scrollView = scrollView;
}


@end
