//
//  LYRWeiboTableInterfaceController.m
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRWeiboTableInterfaceController.h"
#import "LYRWeiboRowController.h"
#import "LYRIconAndUserNameRowController.h"
#import "LYRWeiboContentRowController.h"

#import "LYRWeibo.h"
#import "LYRUserInfo.h"
#import "LYRWeiboTool.h"
#import "LYRWeiboParametersRequest.h"
@interface LYRWeiboTableInterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;
@property(nonatomic,strong)NSMutableArray*weiboArray;
- (IBAction)getNewWeibo;
- (IBAction)getOldWeibo;
@end


@implementation LYRWeiboTableInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.weiboArray = context;
   
    
    [self reloadData];
       
    
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
//刷新列表
-(void)reloadData
{
    //清空列表
    NSRange range = NSMakeRange(0, self.weiboArray.count*2);
    NSIndexSet*set = [[NSIndexSet alloc]initWithIndexesInRange:range];
    [self.table removeRowsAtIndexes:set];
    
    //给列表重新赋值
    for (int i = 0; i<self.weiboArray.count*2; i ++) {
        if (i%2 == 0) {
            //是偶数
            int index = (int)(i*0.5);
            LYRWeibo*weibo = self.weiboArray[index];
            [self.table insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:i] withRowType:@"IconAndUsername"];
            LYRIconAndUserNameRowController*iconAndUserNameC = [self.table rowControllerAtIndex:i];
            [iconAndUserNameC.userNameLabel setText:weibo.user.screen_name];
            NSURL*url = [NSURL URLWithString:weibo.user.profile_image_url];
            [[[NSOperationQueue alloc]init]addOperationWithBlock:^{
                NSData*imgData = [NSData dataWithContentsOfURL:url];
                [[WKInterfaceDevice currentDevice]addCachedImageWithData:imgData name:weibo.user.screen_name];
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    [iconAndUserNameC.iconImage setImageNamed:weibo.user.screen_name];
                }];
            }];
            
            
        }
        if (i%2 ==1) {
            //是偶数
            int index = (int)((i-1)*0.5);
            LYRWeibo*weibo = self.weiboArray[index];
            [self.table insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:i] withRowType:@"weiboContent"];
            LYRWeiboContentRowController*contentC = [self.table rowControllerAtIndex:i];
            [contentC.contentLabel setText:weibo.text];
        }
    }
}
- (IBAction)getNewWeibo {
    //创建请求参数模型
    LYRWeiboParametersRequest*parameters = [[LYRWeiboParametersRequest alloc]init];
    //取出本地微博数组最新一条微博的id 赋值给参数模型since_id
    parameters.since_id = [[self.weiboArray firstObject]idstr];
    //将请求参数模型进行归档 再放入userInfo字典 传入父应用
    NSDictionary*userInfo = @{@"parameters":[NSKeyedArchiver archivedDataWithRootObject:parameters]};
    //请求父应用从网络获取数据
    [WKInterfaceController openParentApplication:userInfo reply:^(NSDictionary *replyInfo, NSError *error) {
        if ([[replyInfo objectForKey:@"code"]isEqualToString:@"0000"]) {
            //请求成功
            //从本地数据库获取微博数据
            NSArray*newModels = [LYRWeiboTool weiboWithParameters:parameters];
            if (newModels.count == 0) {
                //没有新微博
                //提示用户
                NSLog(@"没有新微博");
                return;
            }
            //插入新微薄到本地微博数组
            NSRange range = NSMakeRange(0, newModels.count);
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
            [self.weiboArray insertObjects:newModels atIndexes:set];
            //刷新table
            [self reloadData];
        }
    }];
}

- (IBAction)getOldWeibo {
    //创建请求参数模型
    LYRWeiboParametersRequest*parameters = [[LYRWeiboParametersRequest alloc]init];
    //取出本地微博数组最后一条微博的id 赋值给参数模型max_id
    parameters.max_id = [[self.weiboArray lastObject]idstr];
    //从本地数据库取微博数据
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
                //将旧的微博数据加入本地微博数组
                [self.weiboArray addObjectsFromArray:newModels];
                [self reloadData];
                //将列表跳转至刷新的微博处
                //之前微博数
                NSInteger count =  self.weiboArray.count - newModels.count;
                [self.table scrollToRowAtIndex:count*2 +1];
            }
            
        }];
    } else {
        //数据库有本地数据，将数据添加到本地数组并刷新表格
        [self.weiboArray addObjectsFromArray:models];
        [self reloadData];
        
        //之前微博数
        NSInteger count =  self.weiboArray.count - models.count;
        [self.table scrollToRowAtIndex:count*2 +1];
    }

}
@end



