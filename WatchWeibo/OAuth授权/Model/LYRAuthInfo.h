//
//  LYRAuthInfo.h
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYRAuthInfo : NSObject <NSCoding>
/**
 *  {
 "access_token" = "";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = ;
 }
 */
@property(nonatomic,copy)NSString*access_token;
@property(nonatomic,copy)NSString*expires_in;
@property(nonatomic,copy)NSString*remind_in;
@property(nonatomic,copy)NSString*uid;

/**
 *  过期时间 = 授权那一刻的时间 + expires_in
 */
@property(nonatomic,copy)NSDate *expires_time;
+ (instancetype)authInfoWithDict:(NSDictionary *)dict;
@end
