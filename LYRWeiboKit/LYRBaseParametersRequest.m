//
//  LYRBaseParametersRequest.m
//  WatchWeibo
//
//  Created by 08 on 15/3/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRBaseParametersRequest.h"
#import "LYRAuthInfo.h"
#import "LYRAuthInfoTool.h"
@implementation LYRBaseParametersRequest
-(instancetype)init
{
    if (self = [super init]) {
        self.access_token = [[LYRAuthInfoTool authInfo]access_token];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
}

@end
