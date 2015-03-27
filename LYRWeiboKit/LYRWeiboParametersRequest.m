//
//  LYRWeiboParametersRequest.m
//  WatchWeibo
//
//  Created by 08 on 15/3/26.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRWeiboParametersRequest.h"

@implementation LYRWeiboParametersRequest
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.since_id = [aDecoder decodeObjectForKey:@"since_id"];
        self.max_id = [aDecoder decodeObjectForKey:@"max_id"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.since_id forKey:@"since_id"];
    [aCoder encodeObject:self.max_id forKey:@"max_id"];
}

@end
