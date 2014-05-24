//
//  DPBaseDealListController.h
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPBaseShowDetailController.h"

@interface DPBaseDealListController : DPBaseShowDetailController
{
    UICollectionView *_collectionView;
}
-(NSArray *)totalDeals;//所有团购数据
@end
