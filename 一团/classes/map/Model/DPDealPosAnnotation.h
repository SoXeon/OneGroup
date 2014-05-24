//
//  DPDealPosAnnotation.h
//  一团
//
//  Created by DP on 14-5-24.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@class DPDeal,DPBusiness;
@interface DPDealPosAnnotation : NSObject <MKAnnotation>
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;
@property (nonatomic,strong)DPDeal *deal;
@property (nonatomic,strong)DPBusiness *business;
@property (nonatomic,copy)NSString *icon;
@end
