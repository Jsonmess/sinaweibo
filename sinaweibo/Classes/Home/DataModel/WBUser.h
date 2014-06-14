//
//  WBUser.h
//  sinaweibo
//
//  Created by Json on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject
@property (nonatomic,copy)NSString *screenName;
@property (nonatomic,copy)NSString *location;
@property (nonatomic, copy) NSString *profileImageUrl;
@property (nonatomic, assign) BOOL verified; //是否是微博认证用户，即加V用户
@property (nonatomic, assign) int verifiedType; // 认证类型
@property (nonatomic, assign) int mbrank; // 会员等级
@property (nonatomic, assign) int mbtype; // 会员类型
-(id)initWithDictionary :(NSDictionary*)dic;
@end
