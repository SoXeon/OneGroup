//
//  DPMapViewController.m
//  一团
//
//  Created by 戴鹏 on 14-5-12.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPMapViewController.h"
#import "DPDeal.h"
#import "DPBusiness.h"
#import "DPDealTool.h"
#import "DPDealPosAnnotation.h"
#import "DPMetaDataTool.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>

#define kSpan MKCoordinateSpanMake(0.018404, 0.031468)


@interface DPMapViewController () <MKMapViewDelegate>
{
    MKMapView *_mapView;
    NSMutableArray *_showingDeals;
}
@end

@implementation DPMapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"地图";
    
    //添加地图
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    
    [self.view addSubview:mapView];
    
    
    //初始化数组
    _showingDeals = [NSMutableArray array];
    
    //添加回到用户位置的按钮
    UIButton *backUser = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *image = [UIImage imageNamed:@"btn_map_locate.png"];
    [backUser setBackgroundImage:image forState:UIControlStateNormal];
    [backUser setBackgroundImage:[UIImage imageNamed:@"btn_map_locate_hl.png"] forState:UIControlStateNormal];
    CGFloat w = image.size.width;
    CGFloat h = image.size.height;
    CGFloat x = self.view.frame.size.width - w - 20;
    CGFloat y = self.view.frame.size.height - h - 20;
    backUser.frame = CGRectMake(x,y, w, h);
    backUser.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    [backUser addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backUser];
}

-(void)Back
{
    CLLocationCoordinate2D center = _mapView.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMake(center, kSpan);
    [_mapView setRegion:region animated:YES];
}

#pragma mark mapview的代理方法
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (_mapView) {
        return;
    }
    
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    
    MKCoordinateRegion region = MKCoordinateRegionMake(center, kSpan);
    [mapView setRegion:region animated:YES];
    _mapView = mapView;
}

#pragma mark 拖动地图，区域改变了就会调用
-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    //地图当前展示区域的中心位置
    CLLocationCoordinate2D pos = mapView.region.center;
    
    [[DPDealTool sharedDPDealTool] dealsWithPos:pos success:^(NSArray *deals, int totalCount) {
        for (DPDeal *d in deals) {
            if ([_showingDeals containsObject:d]) {
                continue;
            }
            [_showingDeals addObject:d];
            
            for (DPBusiness *b in d.businesses) {
                DPDealPosAnnotation *anno = [[DPDealPosAnnotation alloc] init];
                anno.business = b;
                anno.deal = d;
                anno.coordinate = CLLocationCoordinate2DMake(b.latitude, b.longitude);
                [mapView addAnnotation:anno];
            }
        }
    } error:nil];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(DPDealPosAnnotation *)annotation
{
    if (![annotation isKindOfClass:[DPDealPosAnnotation class]]) {
        return nil;
    }
    
    //从缓冲池里取出大头针view
    static NSString *ID = @"MKAnnotationView";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    
    //缓冲池里无可循环的大头针view
    if (annoView == nil) {
        annoView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:ID];
    }
    
    //设置大头针的信息
    annoView.annotation = annotation;
    
    annoView.image = [UIImage imageNamed:annotation.icon];
    
    return annoView;
}

#pragma mark 点击了大头针
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    DPDealPosAnnotation *anno = view.annotation;
    [self showDetail:anno.deal];
    
    //让选中的大头针居中
    [mapView setCenterCoordinate:anno.coordinate animated:YES];
    
    //让view周边产生一些阴影
    view.layer.shadowColor = [UIColor redColor].CGColor;
    view.layer.shadowOpacity = 1;
    view.layer.shadowRadius = 10;
}

@end
