//
//  DPDealCell.h
//  一团
//
//  Created by DP on 14-5-18.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDeal;
@interface DPDealCell : UICollectionViewCell

//描述
@property (weak,nonatomic)IBOutlet UILabel *desc;
//图片
@property (weak,nonatomic)IBOutlet UIImageView *image;
//价格
@property (weak,nonatomic)IBOutlet UILabel *price;
//购买人数
@property (weak,nonatomic)IBOutlet UIButton *purchaseCount;
//标签
@property (weak,nonatomic)IBOutlet UIImageView *bage;

@property (nonatomic,strong) DPDeal *deal;

@end
