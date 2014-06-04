//
//  HomeViewController.m
//  sinaweibo
//
//  Created by Json on 14-6-1.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Json_barbuttonitem.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.设置标题
    self.title=@"首页";
    
   // 2.设置左按钮
    UIBarButtonItem *left=[[UIBarButtonItem alloc ]initWithTarget:self action:@selector(WriteWB) Nomal_image:@"navigationbar_compose.png" Highlight_image:@"navigationbar_compose_highlighted.png" ];

    self.navigationItem.leftBarButtonItem=left;
    
    //3.设置右边按钮
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTarget:self action:@selector(PopMenu) Nomal_image:@"navigationbar_pop.png" Highlight_image:@"navigationbar_pop_highlighted.png"];
    
    self.navigationItem.rightBarButtonItem=right;
        
    
   
}
#pragma mark--------导航栏按钮Action
-(void)WriteWB
{
    Debuglog(@"写微博");

}
-(void)PopMenu
{
    Debuglog(@"弹出菜单");
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
