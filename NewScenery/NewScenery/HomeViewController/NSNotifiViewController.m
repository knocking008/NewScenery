//
//  NSNotifiViewController.m
//  NewScenery
//
//  Created by mac on 16/1/14.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSNotifiViewController.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

#define KNewUrl @"http://m.zhinanmao.com/tripapi/sysmsg?page=1&system=iPhone&system_version=9.2&app_id=1&from=app&platform=1&v=2.6.0&phone_type=iPhone8,1&idfa=638B5429-1A2D-411E-B7B2-7ABF8E092A8D"
@interface NSNotifiViewController ()

@end

@implementation NSNotifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/2-50, 200, 100, 100)];
    imageView.image = [UIImage imageNamed:@"noOrder"];
    [self.view addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/2-50, 311, 100, 30)];
    label.text = @"还没有通知哦";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"小喵";
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
@end
