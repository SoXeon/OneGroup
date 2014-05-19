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

#define kItemW 250
#define kItemH 250


@interface DPDealListController () <DPRequestDelegate>
{
    NSMutableArray *_deals;
}

@end

@implementation DPDealListController

- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 30;
    layout.itemSize = CGSizeMake(kItemW, kItemH);
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //监听城市改变的通知
    kAddAllNotes(dataChange)
    
    //设置背景颜色
    self.collectionView.backgroundColor = kGlobalBg;
    
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
    
    DPAPI *api = [[DPAPI alloc]init];
    
    [api requestWithURL:@"v1/deal/find_deals"
                 params:@{
                          @"city":[DPMetaDataTool sharedDPMetaDataTool].currentCity.name
                        } delegate:self];
    
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{

    NSArray *array = result[@"deals"];
    
    _deals = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        DPDeal *d = [[DPDeal alloc]init];
        [d setValues:dict];
        [_deals addObject:d];
    }
    
    [self.collectionView reloadData];
}

#pragma mark 屏幕旋转的时候调用
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    
}

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
@end
