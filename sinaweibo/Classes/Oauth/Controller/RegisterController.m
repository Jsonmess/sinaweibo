//
//  RegisterController.m
//  sinaweibo
//
//  Created by Json on 14-6-2.
//  Copyright (c) 2014年 Json. All rights reserved.
//


//        Debuglog(@"%@",request.URL.absoluteString);

//#pragma mark-------原始创建请求方法
//        NSMutableURLRequest *post=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/access_token"]];
//        post.HTTPMethod=@"POST";
//        NSString *param=[NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",KappKey,KappSecret,thecode,Kappredirect_uri];
//        //Debuglog(@"%@",param);
//        post.HTTPBody=[param dataUsingEncoding:NSUTF8StringEncoding];
//    //设置超时时间
//        post.timeoutInterval=5.0f;



#import "RegisterController.h"
#import "Json_weibo_cfg.h"
#import "AFNetworking.h"
#import "AccountTool.h"
#import "MainController.h"
#import "WBaccount.h"
@interface RegisterController ()<UIWebViewDelegate>
{
    
    UIWebView *_webview;
}
@end

@implementation RegisterController

-(void)loadView
{
    _webview=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view =_webview;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	//1.加载新浪授权登陆界面(获取未授权的Resquest Token)
    NSURL *regist_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&display=%@",KregisterUrl,KappKey,Kappredirect_uri,Kdisplay]];
    NSURLRequest *urlrequest=[NSURLRequest requestWithURL:regist_url];
    [_webview loadRequest:urlrequest];
    [_webview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"register_view_bg.jpg"]]];
    [_webview setDelegate:self];
    
}
#pragma mark----实现UIWebView的方法
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络故障或网路未连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [al show];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1.将请求页面url转为字符串
    NSString *urlStr=request.URL.absoluteString;
    //Debuglog(@"%@",urlStr);
    //2.查找code=的范围
    NSRange range=[urlStr rangeOfString:@"code="];
    if(range.length!=0) {
        //开始截取字符串
        NSInteger index=range.location+range.length;
        NSString *thecode=[urlStr substringFromIndex:index];
       
        //用code换取授权后的accesstoken
        [self GetAccessToken:thecode];
        
        
        return NO;
    }
else{
    return YES;
}
  
}
-(void)GetAccessToken:(NSString *)thecode
{
    //创建post请求   BaseURL只能包含协议头和主机名
    AFHTTPClient *client=[AFHTTPClient  clientWithBaseURL:[NSURL URLWithString:@"https://api.weibo.com"]];
    NSURLRequest *url_request=  [client requestWithMethod:@"POST" path:@"/oauth2/access_token" parameters:@{
                                 @"client_id":KappKey,
                                 @"client_secret":KappSecret,
                                 @"grant_type":@"authorization_code",
                                 @"code":thecode,
                                 @"redirect_uri":Kappredirect_uri
                                 
                                 }];

    //利用AFN框架创建nsurlrequest
    AFJSONRequestOperation *json_op=[AFJSONRequestOperation JSONRequestOperationWithRequest:url_request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //Debuglog(@"请求成功！－－%@",JSON);
        //创建账号对象
        WBaccount *account=[[WBaccount alloc]init];
        account .Uid=JSON[@"uid"];
        account.accessToken=JSON[@"access_token"];
        [[AccountTool SharedAccountTool] SaveWBAccount:account];
        //获取主窗口
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        window.rootViewController=[[MainController alloc]init];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        //Debuglog(@"%@",error.localizedDescription);
    }];
    //开始发送
    [json_op start];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
