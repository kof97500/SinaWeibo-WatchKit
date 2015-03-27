//
//  ViewController.m
//  WatchWeibo
//
//  Created by 08 on 15/3/25.
//  Copyright (c) 2015年 Michael. All rights reserved.
//

#import "ViewController.h"
#import "LYROAuthViewController.h"
@interface ViewController ()

- (IBAction)loginClick;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick {
    LYROAuthViewController*OAuthVC = [[LYROAuthViewController alloc]init];
    [self.navigationController pushViewController:OAuthVC animated:YES];
    
}
@end
