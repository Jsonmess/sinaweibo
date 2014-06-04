//
//  MessageController.m
//  sinaweibo
//
//  Created by Json on 14-6-1.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "MessageController.h"

@interface MessageController ()

@end

@implementation MessageController

- (void)viewDidLoad
{
    self.title=@"消息";
    //添加右边导航按钮
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"发私信" style:UIBarButtonItemStylePlain target:nil action:nil];

    self.navigationItem.rightBarButtonItem=right;
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
