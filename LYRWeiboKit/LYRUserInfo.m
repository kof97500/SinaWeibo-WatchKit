//
//  LYRUserInfo.m
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRUserInfo.h"

@implementation LYRUserInfo
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
        self.profile_image_url = [aDecoder decodeObjectForKey:@"profile_image_url"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.screen_name forKey:@"screen_name"];
    [aCoder encodeObject:self.profile_image_url forKey:@"profile_image_url"];
}
@end
