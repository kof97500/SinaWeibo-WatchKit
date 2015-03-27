//
//  LYRWeiboTool.h
//  WatchWeibo
//
//  Created by 08 on 15/3/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//
/**
 *  操作微博数据 数据库工具类
 */
#import "JSONModel.h"
@class LYRWeiboParametersRequest,LYRWeibo;
@interface LYRWeiboTool : JSONModel

// 保存微博数据(存储到数据库)
+(BOOL)saveWeiboWith:(LYRWeibo*)weibo;

// 读取微博数据(从数据库)
+ (NSArray *)weiboWithParameters:(LYRWeiboParametersRequest *)parameters;
@end
