//
//  LYRWeibo.m
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRWeibo.h"

@implementation LYRWeibo
+(BOOL)propertyIsOptional:(NSString *)propertyName
{
    return YES;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
        self.idstr = [aDecoder decodeObjectForKey:@"idstr"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.idstr forKey:@"idstr"];
}
@end
