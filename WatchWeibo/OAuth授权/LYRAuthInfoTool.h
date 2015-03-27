//
//  LYRAuthInfoTool.h
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LYRAuthInfo;
@interface LYRAuthInfoTool : NSObject
/**
 *  保存授权信息
 *
 *
 *  @return 是否成功
 */
+(BOOL)saveInfoWith:(LYRAuthInfo*)authInfo;
/**
 *  在本地获取授权信息
 */
+(LYRAuthInfo*)authInfo;
@end
