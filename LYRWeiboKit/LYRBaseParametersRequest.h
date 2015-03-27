//
//  LYRBaseParametersRequest.h
//  WatchWeibo
//
//  Created by 08 on 15/3/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "JSONModel.h"

@interface LYRBaseParametersRequest : JSONModel <NSCoding>
@property(nonatomic,copy)NSString*access_token;
@end
