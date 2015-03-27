//
//  LYRUserInfo.h
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface LYRUserInfo : JSONModel<NSCoding>
/**
 *  用户昵称
 */
@property(nonatomic,copy)NSString*screen_name;
/**
 *  头像小图 地址
 */
@property(nonatomic,copy)NSString*profile_image_url;


@end
