//
//  DPDealWebController.m
//  一团
//
//  Created by DP on 14-5-22.
//  Copyright (c) 2014年 戴鹏. All rights reserved.
//

#import "DPDealWebController.h"
#import "DPDeal.h"

@interface DPDealWebController () <UIWebViewDelegate>
{
    UIWebView *_webView;
    UIView *_cover;
}

@end

@implementation DPDealWebController

-(void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.backgroundColor = kGlobalBg;
    _webView.scrollView.backgroundColor = kGlobalBg;
    _webView.delegate = self;
    self.view = _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //[_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_deal.deal_h5_url]]];
    
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@",ID];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark 拦截webView 的请求
-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    _cover = [[UIView alloc]init];
//    _cover.frame = webView.bounds;
//    _cover.backgroundColor = kGlobalBg;
//    _cover.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    [webView addSubview:_cover];
//    
//    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    indicator.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
//    UIViewAutoresizingFlexibleTopMargin;
//    indicator.center = CGPointMake(_cover.frame.size.width * 0.5,_cover.frame.size.height * 0.5 );
//    [_cover addSubview:indicator];
//    [indicator startAnimating];
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    for (UIView *view in webView.scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat height = 70;
    webView.scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    webView.scrollView.contentOffset = CGPointMake(0, -height);
    //1.拼接脚本
    NSMutableString *script = [NSMutableString string];
    //2.取出body
    [script appendString:@"var atraget = document.getElementsByTagName('a')[0];"];
    //3.取出section
    [script appendString:@"var divtraget = document.getElementsByTagName('div')[0];"];
    //4.清空body
    [script appendString:@"var divNexttraget = document.getElementsByTagName('div')[1];"];
    //5.添加section到body
    [script appendString:@"atraget.style.display = \"none\";"];
    [script appendString:@"divtraget.style.display = \"none\";"];
    [script appendString:@"divNexttraget.style.display = \"none\";"];
    
    //执行脚本
    [webView stringByEvaluatingJavaScriptFromString:script];
    
    //移除遮盖
    [_cover removeFromSuperview];
    _cover = nil;
}
@end
