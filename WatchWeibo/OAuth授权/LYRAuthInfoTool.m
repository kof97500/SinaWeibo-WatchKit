//
//  LYRAuthInfoTool.m
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRAuthInfoTool.h"
#import "LYRAuthInfo.h"
#import "LYRAppGroup.h"

#define LYRInfoPath [[[[NSFileManager defaultManager]containerURLForSecurityApplicationGroupIdentifier:LYRGroupID]URLByAppendingPathComponent:@"authInfo.data"]path]
@implementation LYRAuthInfoTool

+(BOOL)saveInfoWith:(LYRAuthInfo *)authInfo
{
    // 计算真正的过期时间
    authInfo.expires_time = [[NSDate date]dateByAddingTimeInterval:[authInfo.expires_in doubleValue]];
    // 将模型写入到沙河中
    return [NSKeyedArchiver archiveRootObject:authInfo toFile:LYRInfoPath];
}
+(LYRAuthInfo *)authInfo
{
    LYRAuthInfo *authInfo =  [NSKeyedUnarchiver unarchiveObjectWithFile:LYRInfoPath];
    if (authInfo == nil) {
        return nil;
    }
    // 判断授权是否过期
    if ([[NSDate date] compare:authInfo.expires_time] == NSOrderedDescending) {
        return nil;
    }
    return authInfo;
}
@end
