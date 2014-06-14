//
//  LoadWBfromNet.m
//  sinaweibo
//
//  Created by Json on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import "LoadWBfrom_toNet.h"
#import "HttpTool.h"
#import "Json_weibo_cfg.h"
#import "WBContent.h"
#import "AccountTool.h"
@implementation LoadWBfrom_toNet
-(void)LoadwbFromSinaWithPath:(NSString *)path success:(SuccessBlock)successblock faild:(FaildBlock)faildblock WithMethod:(NSString *)method
{
    [HttpTool HttpSendwithPath:KbaseUrl path:path Params:@{
     
     @"access_token":[AccountTool sharedAccountTool].account.accessToken
     
     }
     
                   PostSuccess:^(id Json) {
                       if (successblock==nil) return ;
                       //取出json中的数组
                       NSMutableArray *thewb=Json[@"statuses"];
                       for (NSDictionary *di in thewb) {
                           WBContent  *wbcontent=[[WBContent alloc]initWithDictionary:di];
                           //添加微博对象，（追加数据！）
                           NSMutableArray *thewbs=[NSMutableArray array];
                           
                           [thewbs addObject:wbcontent];
                           
                           successblock(thewbs);
                       }
                    
                       
                   } PostFaild:^(NSError *error) {
                       Debuglog(@"%@",error.localizedDescription);
                       //外部可能将空值传入faildblock
                       if (faildblock==nil) return ;
                       
                       faildblock(error);
                       
                   } WithMethod:method];
   

}
@end
