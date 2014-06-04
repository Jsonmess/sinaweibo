//
//  JsonNavigationController.m
//  sinaweibo
//
//  Created by Json on 14-6-1.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "JsonNavigationController.h"

@interface JsonNavigationController ()

@end

@implementation JsonNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    //设置导航栏按钮属性字典
    NSDictionary *dic=@{
                        UITextAttributeTextColor:[UIColor darkGrayColor],
                        UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]
                        };

    //1.设置全局导航栏(appearance能将所有导航栏状态对象返回)
    UINavigationBar *bar=[UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
    [bar setTitleTextAttributes:@{
       UITextAttributeTextColor:[UIColor blackColor],
UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]
     }];
    //2.设置uibarbuttonitem
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_pushed.png"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [item setBackgroundImage:[UIImage imageNamed:@"navigationbar_button_background_disable.png"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
     [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    [item setTitleTextAttributes:dic forState:UIControlStateHighlighted];
    //3.设置状态栏属性，改为默认
    //设置为黑色
    [UIApplication sharedApplication].statusBarStyle=UIStatusBarStyleBlackOpaque ;
    
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
