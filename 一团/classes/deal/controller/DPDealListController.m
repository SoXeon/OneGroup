//
//  DPDealListController.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealListController.h"
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

#import "DPDealDetailController.h"
#import "DPNavigationController.h"

#import "DPCover.h"

#define kItemW 250
#define kItemH 250


@interface DPDealListController () <MJRefreshBaseViewDelegate>
{
    NSMutableArray *_deals;
    int _page;//页码
    MJRefreshFooterView *_footer;//下拉加载更多
    MJRefreshHeaderView *_header;

}

@end

@implementation DPDealListController

-(NSArray *)totalDeals
{
    return _deals;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //基本设置
    [self baseSetting];
    
    //添加刷新控件
    [self addRefresh];
    
    [DPMetaDataTool sharedDPMetaDataTool].currentCity = [DPMetaDataTool sharedDPMetaDataTool].totalCities[@"上海"];
    
}

#pragma mark 下拉刷新，上拉加载更多
-(void)addRefresh
{
    
    NSComparisonResult order = [[UIDevice currentDevice].systemVersion compare: @"7.0" options: NSNumericSearch];
    if (order == NSOrderedSame || order == NSOrderedDescending)
    {
         //OS version >= 7.0
        self.edgesForExtendedLayout = UIRectEdgeNone;
   }
    
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = _collectionView;
    header.delegate = self;
    _header = header;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _collectionView;
    footer.delegate = self;
    _footer = footer;
}

#pragma mark 刷新代理方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    BOOL isHeader = [refreshView isKindOfClass:[MJRefreshFooterView class]];
    if (isHeader) {
        //清除图片缓存
        [DPImageTool clear];
        _page = 1;
    }  else {
        //上拉加载
        _page++;
    }
    
    [[DPDealTool sharedDPDealTool] dealsWithPage:_page success:^(NSArray *deals, int totalCount) {
        
        //数据加载完毕以后，才清空，重新加载新数据
        if (isHeader) {
            _deals = [NSMutableArray array];
        }
        //添加数据
        [_deals addObjectsFromArray:deals];
        //刷新表格
        [_collectionView reloadData];
        //恢复刷新状态
        [refreshView endRefreshing];
        //判断下拉加载更多是否要刷新
        _footer.hidden = _deals.count >= totalCount;
    } error:^(NSError *error){
        //恢复刷新状态
        [refreshView endRefreshing];
    }];
}

- (void)baseSetting
{
    //监听城市改变的通知
    kAddAllNotes(dataChange)
    
    //右边搜索框
    UISearchBar *s = [[UISearchBar alloc]init];
    s.frame = CGRectMake(0, 0, 210, 35);
    s.placeholder = @"请输入商品名、地址等";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:s];
    
    //左边的顶部菜单栏
    DPDealTopMenu *top = [[DPDealTopMenu alloc] init];
    top.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:top];
    
}



-(void)dataChange
{
    [_header beginRefreshing];
    _deals = [NSMutableArray array];
    _page = 1;
    [[DPDealTool sharedDPDealTool] dealsWithPage:_page success:^(NSArray *deals,int totalCount) {
        [_deals addObjectsFromArray:deals];
        
        [_collectionView reloadData];
    } error:nil];
}

@end
