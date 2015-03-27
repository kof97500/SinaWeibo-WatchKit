//
//  LYRAuthInfo.m
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRAuthInfo.h"

@implementation LYRAuthInfo

+ (instancetype)authInfoWithDict:(NSDictionary *)dict
{
    LYRAuthInfo *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.expires_in = dict[@"expires_in"];
    account.remind_in = dict[@"remind_in"];
    account.uid = dict[@"uid"];
    return account;
}
// 将对象写入到文件时调用
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.remind_in forKey:@"remind_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
}
// 从文件中读取对象时调用
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
    }
    return self;
}
@end
