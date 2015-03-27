//
//  LYRHttpTool.h
//  WatchWeibo
//
//  Created by 08 on 15/3/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYRWeiboParametersRequest;
@interface LYRHttpTool : NSObject
/**
 *  获取微博数据 网络
 *
 *  @param parameters 获取参数
 *  @param success    成功的回调
 *  @param failure    失败的回调
 */
+ (void)weiboWithParameters:(LYRWeiboParametersRequest *)parameters   statusToolSuccess:(void (^)(id responseObject))success failure:(void(^)(NSError*error))failure;


@end
