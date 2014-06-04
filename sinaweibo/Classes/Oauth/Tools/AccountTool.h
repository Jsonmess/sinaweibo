//
//  AccountTool.h
//  sinaweibo
//
//  Created by Jsion on 14-6-3.
//  Copyright (c) 2014年 Json. All rights reserved.
//
//用于管理账号
//工具类，只需要一个对象就可以了，所以应该优化为单例
#import <Foundation/Foundation.h>
#import "WBaccount.h"
@interface AccountTool : NSObject

@property(nonatomic,strong)WBaccount *account;
@property (nonatomic,copy)NSString *filepath;

-(void)SaveWBAccount:(WBaccount *)account;
+(id)SharedAccountTool;
@end
