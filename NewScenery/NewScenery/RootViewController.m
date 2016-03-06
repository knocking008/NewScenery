//
//  RootViewController.m
//  NewScenery
//
//  Created by mac on 16/1/11.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "RootViewController.h"

#import "NSHomePageRootViewController.h"
#import "NSSpecialRootViewController.h"
#import "NSCalendarRootViewController.h"
#import "NSUserRootViewController.h"

#import "NSHomeViewController.h"
#import "NSSpecialViewController.h"
#import "NSCalendarViewController.h"
#import "NSUserViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSHomePageRootViewController *homeRootVC = [[NSHomePageRootViewController alloc] init];
    NSHomeViewController *homeVC = [[NSHomeViewController alloc] initWithRootViewController:homeRootVC];
  
    
    NSSpecialRootViewController *specialRootVC = [[NSSpecialRootViewController alloc] init];
    NSSpecialViewController *specialVC = [[NSSpecialViewController alloc] initWithRootViewController:specialRootVC];
    
    NSCalendarRootViewController *alendarRootVC = [[NSCalendarRootViewController alloc] init];
    NSCalendarViewController *calendarVC = [[NSCalendarViewController alloc] initWithRootViewController:alendarRootVC];
    
    NSUserRootViewController *userRootVC = [[NSUserRootViewController alloc] init];
    NSUserViewController *userVC = [[NSUserViewController alloc] initWithRootViewController:userRootVC];
    
    self.viewControllers = @[homeVC,specialVC,calendarVC,userVC];
    
    
}
- (void)aciotn{};


@end
