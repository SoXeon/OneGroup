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

#define kDetailWitdh 600


@interface DPDealListController () <DPRequestDelegate,MJRefreshBaseViewDelegate>
{
    NSMutableArray *_deals;
    int _page;//页码
    MJRefreshFooterView *_footer;//下拉加载更多
    MJRefreshHeaderView *_header;
    
    DPCover *_cover;
}

@end

@implementation DPDealListController

- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kItemW, kItemH);
    layout.minimumLineSpacing = 20;
    return [self initWithCollectionViewLayout:layout];
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
    header.scrollView = self.collectionView;
    header.delegate = self;
    _header = header;
    
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.collectionView;
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
        if (isHeader) {
            _deals = [NSMutableArray array];
        }
        //添加数据
        [_deals addObjectsFromArray:deals];
        //刷新表格
        [self.collectionView reloadData];
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
    
    //设置背景颜色
    self.collectionView.backgroundColor = kGlobalBg;
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    //右边搜索框
    UISearchBar *s = [[UISearchBar alloc]init];
    s.frame = CGRectMake(0, 0, 210, 35);
    s.placeholder = @"请输入商品名、地址等";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:s];
    
    //左边的菜单栏
    DPDealTopMenu *top = [[DPDealTopMenu alloc] init];
    top.contentView = self.view;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:top];
    
    //注册cell的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"DPDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
    
    //设置collectionView永远支持垂直滚动
    self.collectionView.alwaysBounceVertical = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //默认计算layout
    [self didRotateFromInterfaceOrientation:0];
}


-(void)dataChange
{
    [_header beginRefreshing];
    _deals = [NSMutableArray array];
    _page = 1;
    [[DPDealTool sharedDPDealTool] dealsWithPage:_page success:^(NSArray *deals,int totalCount) {
        [_deals addObjectsFromArray:deals];
        
        [self.collectionView reloadData];
    } error:nil];
}

#pragma mark 屏幕旋转的时候调用
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //取出layout
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    //计算间距
    CGFloat v = 20;
    CGFloat h = 0;
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
      h = (self.view.frame.size.width - 3 * kItemW) / 4;
    } else {
      h = (self.view.frame.size.width - 2 * kItemW) / 3;
    }
    [UIView animateWithDuration:1.0 animations:^{
        layout.sectionInset = UIEdgeInsetsMake(v, h, v, h);
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _deals.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"deal";
    
    DPDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.deal = _deals[indexPath.row];
   
    return cell;
}

#pragma mark -代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetail:_deals[indexPath.row]];
}

#pragma mark 显示详情控制器
-(void)showDetail:(DPDeal *)deal
{
    if (_cover == nil) {
        _cover = [DPCover coverWithTarget:self action:@selector(hideDetail)];}
    _cover.frame = self.navigationController.view.bounds;
    _cover.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        [_cover reset];
    }];
    [self.navigationController.view addSubview:_cover];
    
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
