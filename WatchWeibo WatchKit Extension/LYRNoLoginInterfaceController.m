//
//  LYRNoLoginInterfaceController.m
//  WatchWeibo
//
//  Created by 08 on 15/3/27.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "LYRNoLoginInterfaceController.h"


@interface LYRNoLoginInterfaceController()
- (IBAction)backClick;

@end


@implementation LYRNoLoginInterfaceController

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

- (IBAction)backClick {
    [self popController];
}
@end



