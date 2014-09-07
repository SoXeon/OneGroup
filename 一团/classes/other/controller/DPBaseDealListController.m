//
//  DPBaseDealListController.m
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPBaseDealListController.h"
#import "DPDeal.h"
#import "DPDealCell.h"


#define kItemW 250
#define kItemH 250

@interface DPBaseDealListController () <UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation DPBaseDealListController


-(void)viewDidLoad
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kItemW, kItemH);
    layout.minimumLineSpacing = 20;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    //注册cell的xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"DPDealCell" bundle:nil] forCellWithReuseIdentifier:@"deal"];

    self.collectionView.backgroundColor = kGlobalBg;
    
    //设置collectionView永远支持垂直滚动
    self.collectionView.alwaysBounceVertical = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    //默认计算layout
    [self didRotateFromInterfaceOrientation:0];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

#pragma mark 代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetail:self.totalDeals[indexPath.row]];
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalDeals.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"deal";
    
    DPDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.deal = self.totalDeals[indexPath.row];
                            
    return cell;
}

@end
