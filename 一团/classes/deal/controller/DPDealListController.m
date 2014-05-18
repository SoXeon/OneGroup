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
#import "NSObject+Value.h"

@interface DPDealListController () <DPRequestDelegate>
{
    NSMutableArray *_deals;
}

@end

@implementation DPDealListController

- (id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(250, 250);
    layout.minimumLineSpacing = 30;
    layout.sectionInset = UIEdgeInsetsMake(35, 35, 35, 35);
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //监听城市改变的通知
    kAddAllNotes(dataChange)
    
    //设置背景颜色
    self.view.backgroundColor = kGlobalBg;
    
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
    [self.collectionView registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];
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

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"deal";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
   
    return cell;
}
@end
