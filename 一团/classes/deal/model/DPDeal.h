//
//  Deal.h
//  团购
//
//  Created by mj on 13-11-2.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  一个团购模型

#import <Foundation/Foundation.h>
@interface DPDeal : NSObject
@property (nonatomic, copy) NSString *deal_id; // 团购ID
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *desc; // 描述
@property (nonatomic, assign) double list_price;
@property (nonatomic, assign) double current_price; // 当前价格

@property (nonatomic, readonly) NSString *list_price_text;
@property (nonatomic, readonly) NSString *current_price_text; // 当前价格

@property (nonatomic, strong) NSArray *regions; // 区域
@property (nonatomic, strong) NSArray *categories; // 分类
@property (nonatomic, assign) int purchase_count; // 已购买人数
@property (nonatomic, strong) NSString *publish_date; // 发布日期
@property (nonatomic, strong) NSString *purchase_deadline; // 下架日期
@property (nonatomic, copy) NSString *image_url; // 图片
@property (nonatomic, copy) NSString *s_image_url; // 小图
@property (nonatomic, copy) NSString *deal_h5_url; // 链接
@end