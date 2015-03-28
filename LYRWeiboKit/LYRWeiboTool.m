//
//  LYRWeiboTool.m
//  WatchWeibo
//
//  Created by 08 on 15/3/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRWeiboTool.h"
#import "FMDB.h"
#import "LYRWeibo.h"
#import "LYRAuthInfo.h"
#import "LYRAuthInfoTool.h"
#import "LYRWeiboParametersRequest.h"
#import "LYRAppGroup.h"

#define LYRDataBasePath [[[[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:LYRGroupID]URLByAppendingPathComponent:@"weibo.sqlite"]path] //数据库路径
@interface LYRWeiboTool ()

@end
@implementation LYRWeiboTool
static  FMDatabaseQueue*_queue;
/**
 *  在程序调用这个类的时候调用一次
 */
+ (void)load
{
    NSLog(@"%@",LYRDataBasePath);
    _queue = [FMDatabaseQueue databaseQueueWithPath:LYRDataBasePath];
    [_queue inDatabase:^(FMDatabase *db) {
        NSString*sql = @"create Table if not exists t_weibo(weiboInfo BLOB, id INTEGER PRIMARY KEY AUTOINCREMENT,weibo_id Number,access_token TEXT)";
        if ([db executeUpdate:sql]) {
            //建表成功
        } else {
            //建表失败
        }
    }];
    [_queue close];
}
// 保存微博数据(存储到数据库)
+(BOOL)saveWeiboWith:(LYRWeibo*)weibo
{
    __block BOOL flag;
    NSString*access_token = [[LYRAuthInfoTool authInfo]access_token];
    [_queue inDatabase:^(FMDatabase *db) {
        flag = [db executeUpdate:@"insert into t_weibo(weiboInfo,weibo_id,access_token)values(?,?,?)",[NSKeyedArchiver archivedDataWithRootObject:weibo],weibo.idstr,access_token];
    }];
    [_queue close];
    return flag;
}
// 读取微博数据(从数据库)
+ (NSArray *)weiboWithParameters:(LYRWeiboParametersRequest *)parameters
{
    NSMutableArray*models = [NSMutableArray array];
    __block FMResultSet*rs = nil;
    NSString*access_token = [[LYRAuthInfoTool authInfo]access_token];
    [_queue inDatabase:^(FMDatabase *db) {
        if (parameters.since_id !=nil) {
            //查询大于since_id 的微博
           rs =  [db executeQuery:@"select *from t_weibo where access_token = ? and weibo_id > ? ORDER BY weibo_id DESC LIMIT 0, 10;",access_token,parameters.since_id];
        } else if (parameters.max_id !=nil) {
            // 查询小于或等于max_id的微博
            rs =  [db executeQuery:@"select *from t_weibo where access_token = ? and weibo_id < ? ORDER BY weibo_id DESC LIMIT 0, 10;",access_token,parameters.max_id];
        } else {
            // 查询前10条微博
            rs =  [db executeQuery:@"select *from t_weibo where access_token = ?ORDER BY weibo_id DESC LIMIT 0, 10;",access_token];
        }
        // 遍历所有查询到的结果, 将查询的结果转换为模型之后放入数组中返回
        while ([rs next]) {
            LYRWeibo*weibo = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"weiboInfo"]];
            [models addObject:weibo];
        }
    }];
    [_queue close];
    return models;
}
@end
