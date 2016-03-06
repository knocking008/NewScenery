//
//  NSAllMemberDetalViewController.m
//  NewScenery
//
//  Created by mac on 16/2/17.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSAllMemberDetalViewController.h"
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
@interface NSAllMemberDetalViewController ()
@property (nonatomic, strong)UIView *coverView;
@end

@implementation NSAllMemberDetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self moreDetailInfo];
}

- (void)moreDetailInfo
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleStr;
    //创建蒙版view
    self.coverView = [[UIView alloc] initWithFrame:self.view.frame];
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kWidth/2.0-25, KHeight/2.0-25, 50, 50)];
    
    juhua.backgroundColor = [UIColor lightGrayColor];
    [juhua startAnimating];
    [self.coverView addSubview:juhua];
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:webView];
    if (self.appID.length!=0) {
        
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.appID]]];
        self.coverView.hidden = YES;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

@end
