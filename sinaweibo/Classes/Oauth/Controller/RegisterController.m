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
#import "HttpTool.h"
#import "AccountTool.h"
#import "MainController.h"
#import "WBaccount.h"
#import "MBProgressHUD.h"
@interface RegisterController ()<UIWebViewDelegate>
{
    
    UIWebView *_webview;
    MBProgressHUD*_hud;
}
@end

@implementation RegisterController


- (void)viewDidLoad
{
    _webview=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    [self.view addSubview:_webview];

    [super viewDidLoad];
	//1.加载新浪授权登陆界面(获取未授权的Resquest Token)
    NSURL *regist_url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@&display=%@",KregisterUrl,KappKey,Kappredirect_uri,Kdisplay]];
    NSURLRequest *urlrequest=[NSURLRequest requestWithURL:regist_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
    [_webview loadRequest:urlrequest];
    [_webview setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"register_view_bg.jpg"]]];
    [_webview setDelegate:self];
    
}
#pragma mark----实现UIWebView代理的方法
//开始加载数据
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    //创建指示器
    MBProgressHUD*hud= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"正在加载中...."];
    _hud=hud;
    [hud setDimBackground:YES];
    
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{

    //隐藏所有指示器
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

}
//-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    Debuglog(@"%@",error.localizedDescription);
//}
//-(void)RequestError
//{
//    
//    //隐藏所有指示器
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    UIAlertView *al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"网络故障或网路未连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    [al show];
//    Debuglog(@"网络故障或网路未连接");
//}
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
    [HttpTool HttpSendwithPath:@"https://api.weibo.com" path:@"/oauth2/access_token" Params:@{
          @"client_id":KappKey,
          @"client_secret":KappSecret,
         @"grant_type":@"authorization_code",
          @"code":thecode,
         @"redirect_uri":Kappredirect_uri
        
         }
 PostSuccess:^(id Json) {
     //隐藏所有指示器
           [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
          //创建账号对象
            WBaccount *account=[[WBaccount alloc]init];
     Debuglog(@"json %@",Json);
            account .Uid=Json[@"uid"];
           account.accessToken=Json[@"access_token"];
            [[AccountTool sharedAccountTool] saveAccount:account];
           //获取主窗口
            UIWindow *window=[UIApplication sharedApplication].keyWindow;
            window.rootViewController=[[MainController alloc]init];
     
 } PostFaild:^(NSError *error) {
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     
     
 } WithMethod:@"POST"];
    }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
