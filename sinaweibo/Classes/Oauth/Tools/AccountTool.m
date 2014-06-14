//
//  AccountTool.m
//  sinaweibo
//
//  Created by Jsion on 14-6-3.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "AccountTool.h"

// 文件路径
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation AccountTool

single_implementation(AccountTool)

- (id)init
{
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

- (void)saveAccount:(WBaccount *)account
{
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}
@end

