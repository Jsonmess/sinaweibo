//
//  HomeViewController.m
//  sinaweibo
//
//  Created by Json on 14-6-1.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Json_barbuttonitem.h"
#import "WBContent.h"
#import "LoadWBfrom_toNet.h"
@interface HomeViewController ()
{
    NSMutableArray *_thewb;
    WBContent *_Wbcontent;
}
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
    //设置主界面属性
    [self SetupView];
    //获取新浪微博数据
    [self GetResourceFromSina];
    
}

#pragma mark----设置主界面属性
-(void)SetupView
{
    //1.设置标题
    self.title=@"首页";
    
    // 2.设置左按钮
    UIBarButtonItem *left=[[UIBarButtonItem alloc ]initWithTarget:self action:@selector(WriteWB) Nomal_image:@"navigationbar_compose.png" Highlight_image:@"navigationbar_compose_highlighted.png" ];
    
    self.navigationItem.leftBarButtonItem=left;
    
    //3.设置右边按钮
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTarget:self action:@selector(PopMenu) Nomal_image:@"navigationbar_pop.png" Highlight_image:@"navigationbar_pop_highlighted.png"];
    
    self.navigationItem.rightBarButtonItem=right;
    
    //初始化存储微博数据数组
    _thewb=[NSMutableArray array];
    
}
#pragma mark--------获取新浪微博服务器数据
-(void)GetResourceFromSina
{
    
    LoadWBfrom_toNet *loadwb=[[LoadWBfrom_toNet alloc]init];
    //path是附属路径
    [loadwb LoadwbFromSinaWithPath:@"/2/statuses/home_timeline.json" success:^(NSArray *thewbs) {
        [_thewb addObjectsFromArray:thewbs];
       [self.tableView reloadData];
        
    } faild:^(NSError *error) {
        
    }WithMethod:@"GET"];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _thewb.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //创建微博对象
    WBContent *wbcontent=_thewb[indexPath.row];
    //设置cell属性
    cell.textLabel.text=wbcontent.text;
    cell.detailTextLabel.text=wbcontent.TheUser.screenName;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
