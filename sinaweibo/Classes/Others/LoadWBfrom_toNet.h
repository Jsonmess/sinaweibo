//
//  LoadWBfromNet.h
//  sinaweibo
//
//  Created by Json on 14-6-6.
//  Copyright (c) 2014年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSArray *thewbs);
typedef void (^FaildBlock)(NSError *error);
@interface LoadWBfrom_toNet : NSObject

-(void)LoadwbFromSinaWithPath :(NSString *)path success:(SuccessBlock)successblock faild:(FaildBlock)faildblock WithMethod:(NSString *)method;
@end
