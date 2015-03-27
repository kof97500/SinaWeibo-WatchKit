//
//  LYRWeiboParametersRequest.h
//  WatchWeibo
//
//  Created by 08 on 15/3/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRBaseParametersRequest.h"

@interface LYRWeiboParametersRequest : LYRBaseParametersRequest 
@property(nonatomic,copy)NSString*since_id;

@property(nonatomic,copy)NSString*max_id;
@end
