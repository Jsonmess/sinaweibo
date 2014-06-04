//
//  WBaccount.h
//  sinaweibo
//
//  Created by Json on 14-6-2.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBaccount : NSObject<NSCoding>
@property(nonatomic,copy)NSString *accessToken;
@property(nonatomic,copy)NSString *uid;

@end
