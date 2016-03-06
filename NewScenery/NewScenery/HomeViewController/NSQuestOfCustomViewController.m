//
//  NSQuestOfCustomViewController.m
//  NewScenery
//
//  Created by mac on 16/1/15.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSQuestOfCustomViewController.h"

#define KQCUrlStr @"http://m.zhinanmao.com/tripwap/article?id=22"
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
@interface NSQuestOfCustomViewController ()
@property (nonatomic, strong)UIView *coverView;
@end
@implementation NSQuestOfCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self moreDetailInfo];
}
- (void)moreDetailInfo
{
    //创建蒙版view
    self.coverView = [[UIView alloc] initWithFrame:self.view.frame];
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kWidth/2.0-25, KHeight/2.0-25, 50, 50)]; juhua.backgroundColor = [UIColor lightGrayColor];
    [juhua startAnimating];
    [self.coverView addSubview:juhua];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KQCUrlStr]]];
     self.coverView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"什么是旅行定制服务_···";
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

@end
