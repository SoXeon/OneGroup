//
//  DPInfoHeaderView.h
//  一团
//
//  Created by DP on 14-5-23.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPRoundRectView.h"
@class DPDeal;
@interface DPInfoHeaderView : DPRoundRectView

@property (weak,nonatomic) IBOutlet UIImageView *image;
@property (weak,nonatomic) IBOutlet UILabel *desc;
@property (weak,nonatomic) IBOutlet UIButton *anyTimeBack;
@property (weak,nonatomic) IBOutlet UIButton *expireBack;
@property (weak,nonatomic) IBOutlet UIButton *time;
@property (weak,nonatomic) IBOutlet UIButton *purchaseCount;


@property (nonatomic,strong) DPDeal *deal;
+(id)infoHeaderView;
@end
