//
//  WBContent.m
//  sinaweibo
//
//  Created by Json on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "WBContent.h"

@implementation WBContent
-(id)initWithDictionary:(NSDictionary *)dic
{
    if (self=[super init]) {
    
        self.TheUser=[[WBUser alloc]initWithDictionary:dic[@"user"]];
        
        self.text=dic[@"text"];
        self.picUrls = dic[@"pic_urls"];
        //防止后期传空值是影响判断
        NSDictionary *retweet = dic[@"retweeted_status"];
        if (retweet) {
            self.retweetedStatus = [[WBContent alloc] initWithDictionary:retweet];
        }
        
        self.createdAt = dic[@"created_at"];
        self.source = dic[@"source"];
        
        self.repostsCount = [dic[@"reposts_count"] intValue];
        self.commentsCount = [dic[@"comments_count"] intValue];
        self.attitudesCount = [dic[@"attitudes_count"] intValue];
    }
    return self;
    
}
@end
