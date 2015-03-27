//
//  InterfaceController.m
//  WatchWeibo WatchKit Extension
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "InterfaceController.h"
#import "FMDB.h"
#import "LYRWeibo.h"
#import "LYRWeiboParametersRequest.h"
#import "LYRWeiboTool.h"
@interface InterfaceController()
- (IBAction)weiboClick;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)weiboClick {
    //进入首页，不需要参数
    LYRWeiboParametersRequest*parameters = [[LYRWeiboParametersRequest alloc]init];
    //判断是否登录
    if (parameters.access_token.length == 0) {
        //没有登录信息
        [self pushControllerWithName:@"notLogin" context:nil];
        return;
    }
    NSLog(@"%@",parameters);
    //检查数据库是否有数据
    NSArray*models = [LYRWeiboTool weiboWithParameters:parameters];
    if (models.count == 0) {
        NSDictionary*userInfo = @{@"parameters":[NSKeyedArchiver archivedDataWithRootObject:parameters]};
        //数据库没有数据，需要让iphone请求数据 并存入数据库
        [WKInterfaceController openParentApplication:userInfo reply:^(NSDictionary *replyInfo, NSError *error) {
            NSLog(@"%@",replyInfo);
            if ([[replyInfo objectForKey:@"code"]isEqualToString:@"0000"]) {
                //请求数据成功
                //请求完毕 再次从数据库取数据
                NSArray*newModels = [LYRWeiboTool weiboWithParameters:parameters];
                //跳转至微博列表 并将微博模型数据传入
                [self pushControllerWithName:@"weibo" context:newModels];
            }
          
        }];
    } else {
        //数据库有本地数据，直接跳转
        [self pushControllerWithName:@"weibo" context:models];
    }
}

@end



