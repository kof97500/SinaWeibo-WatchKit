//
//  LYRHttpTool.m
//  WatchWeibo
//
//  Created by 08 on 15/3/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRHttpTool.h"
#import "AFNetworking.h"
#import "LYRWeiboParametersRequest.h"
@implementation LYRHttpTool
+ (void)weiboWithParameters:(LYRWeiboParametersRequest *)parameters   statusToolSuccess:(void (^)(id responseObject))success failure:(void(^)(NSError*error))failure
{
    NSString*urlString = @"https://api.weibo.com/2/statuses/friends_timeline.json";
   __block NSDictionary*md;
    if (parameters.since_id !=nil) {
        md = @{@"access_token":parameters.access_token,@"since_id":parameters.since_id,@"count":@"10"};
    } else if (parameters.max_id !=nil){
         md = @{@"access_token":parameters.access_token,@"max_id":parameters.max_id,@"count":@"10"};
    } else {
         md = @{@"access_token":parameters.access_token,@"count":@"10"};
    }
    AFHTTPRequestOperationManager*manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:md success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
@end
