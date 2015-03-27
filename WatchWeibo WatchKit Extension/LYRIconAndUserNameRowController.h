//
//  LYRIconAndUserNameRowController.h
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>
@interface LYRIconAndUserNameRowController : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceImage *iconImage;

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *userNameLabel;
@end
