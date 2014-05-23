//
//  DPBuyDock.h
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDeal,DPLineLabel;
@interface DPBuyDock : UIView
@property (weak, nonatomic) IBOutlet DPLineLabel *listPrice;
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
@property (nonatomic,strong) DPDeal *deal;

+(id)buyDock;
@end
