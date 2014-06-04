//
//  WBaccount.m
//  sinaweibo
//
//  Created by Json on 14-6-2.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "WBaccount.h"

@implementation WBaccount
//实现nscoding中的归档方法
-(void)encodeWithCoder:(NSCoder *)enCoder
{
    //使用键值存储
   [enCoder encodeObject:_accessToken forKey:@"access_token"];
    [enCoder encodeObject:_uid forKey:@"uid"];
}
//初始化方法中，进行解档
-(id)initWithCoder:(NSCoder *)aDecoder
{

    if (self=[super init]) {
        _accessToken=  [aDecoder decodeObjectForKey:@"access_token"];
        _uid=  [aDecoder decodeObjectForKey:@"uid"];
    }
    return self;
}
@end
