//
//  LYRWeibo.h
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@class LYRUserInfo;
@interface LYRWeibo : JSONModel<NSCoding>
/**
 *  微博内容
 */
@property(nonatomic,copy)NSString*text;

@property(nonatomic,strong)LYRUserInfo*user;

/**
 *  微博id
 */
@property(nonatomic,copy)NSString*idstr;
@end
