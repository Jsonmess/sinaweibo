//
//  AccountTool.m
//  sinaweibo
//
//  Created by Jsion on 14-6-3.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "AccountTool.h"
#import "WBaccount.h"
@implementation AccountTool
static AccountTool *_instance;
#pragma mark----创建单例模板
+(id)SharedAccountTool
{
    if (_instance ==nil) {
        _instance=[[self alloc]init];//这个会默认调用allocWithZone
    
}
    return _instance;
}
+(id)allocWithZone:(NSZone *)zone
{
    //防止多个线程运行时候，创建多个对象
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance=[super allocWithZone:zone];
    });
    return _instance;
}
-(void)SaveWBAccount:(WBaccount *)account
{
    _account=account;//当前保存的账号，同时也将其记录在成员变量中
    //设置存储路径
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=array[0];//数组只有一个值，因为沙盒只有一个
    self.filepath=[path stringByAppendingPathComponent:@"WbAccount.data"];
    [NSKeyedArchiver archiveRootObject:account toFile:self.filepath];
}
//当外部类调用工具类（再次访问，不输入密码）时候，成员account为nil，所以在构造方法中需要读取文件中的账户信息
-(id)init
{
    if (self=[super init]) {
        
      self.account=  [NSKeyedUnarchiver unarchiveObjectWithFile:self.filepath];
        
    }
    return self;
}

@end
