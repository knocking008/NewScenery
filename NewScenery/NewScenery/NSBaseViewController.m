//
//  NSBaseViewController.m
//  NewScenery
//
//  Created by mac on 16/1/15.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSBaseViewController.h"

@interface NSBaseViewController ()

@end

@implementation NSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
