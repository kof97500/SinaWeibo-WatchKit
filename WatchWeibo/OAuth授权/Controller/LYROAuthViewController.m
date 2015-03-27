//
//  LYROAuthViewController.m
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYROAuthViewController.h"
#import "AFNetworking.h"
#import "LYRAuthInfo.h"
#import "LYRAuthInfoTool.h"

#define LYRAppKey @""
#define LYRRedirectURL @""
#define LYRAppSecret @""
@interface LYROAuthViewController ()<UIWebViewDelegate>

@end

@implementation LYROAuthViewController
-(void)loadView
{
    self.view = [[UIWebView alloc]init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self webViewLoadRequest];
}
/**
 *  加载用户登陆页
 */
-(void)webViewLoadRequest
{
    // 1.拼接URL
    NSString*str = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",LYRAppKey,LYRRedirectURL];
    NSURL*url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
     // 2.利用UIWebView加载网页
    UIWebView*webView = (UIWebView*)self.view;
    webView.delegate = self;
    [webView loadRequest:request];
}
-(void)accessTokenWithRequestToken:(NSString*)requestToken
{
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    // 告诉AFN可以接收 text/plain这种类型的返回数据
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    //参数字典
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[@"client_id"] = LYRAppKey;
    md[@"client_secret"] = LYRAppSecret;
    md[@"grant_type"] = @"authorization_code";
    md[@"code"] = requestToken;
    md[@"redirect_uri"] = LYRRedirectURL;
    
    NSString*urlString = @"https://api.weibo.com/oauth2/access_token";
    
    [manager POST:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        LYRAuthInfo*info = [LYRAuthInfo authInfoWithDict:responseObject];
        if ([LYRAuthInfoTool saveInfoWith:info]) {
            NSLog(@"保存成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - UIWebViewDelegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.判断即将要发起的请求地址中是否包含code=, 如果包含截取code=之后的字符(已经授权的RequestToken)
    //获得请求的字符串
    NSString*urlString = request.URL.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    if (range.length != 0) {
        //找到code=
        NSInteger index = range.location + range.length;
        NSString*requestToken = [urlString substringFromIndex:index];
        [self accessTokenWithRequestToken:requestToken];
        return NO;
    }
    return YES;
}
/**
 *  开始请求时调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//    NSLog(@"加载中");
}
/**
 *  请求完毕调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSLog(@"加载完毕");
}
/**
 *  请求错误时调用
 */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    NSLog(@"%@",error);
}

@end
