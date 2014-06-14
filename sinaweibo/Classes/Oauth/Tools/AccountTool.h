//
//  AccountTool.h
//  sinaweibo
//
//  Created by Jsion on 14-6-3.
//  Copyright (c) 2014年 Json. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "AccountTool.h"
#import "Singleton.h"
#import "WBaccount.h"
@interface AccountTool : NSObject

single_interface(AccountTool)

- (void)saveAccount:(WBaccount *)account;

// 获得当前账号
@property (nonatomic, readonly) WBaccount *account;
@end