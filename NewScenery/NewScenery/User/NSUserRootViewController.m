//
//  NSUserRootViewController.m
//  NewScenery
//
//  Created by mac on 16/1/25.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSUserRootViewController.h"
#import "NSHomeMassageViewController.h"

#import "NSAllMemberViewController.h"
#import "NSfeedBackViewController.h"
#import "NSHelpViewController.h"
@interface NSUserRootViewController ()

@end

@implementation NSUserRootViewController
- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"user"] selectedImage:[UIImage imageNamed:@"userHL"]];
        UIButton *massageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        massageBtn.frame = CGRectMake(0, 0, 44, 44);
        [massageBtn setImage:[UIImage imageNamed:@"grayMessage"] forState:UIControlStateNormal];
        [massageBtn setTitle:@"消息" forState:UIControlStateNormal];
        [massageBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        massageBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        massageBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -44, -30, 0);
        [massageBtn addTarget:self action:@selector(rightBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:massageBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
        self.navigationItem.title = @"我的领地";
    }
    return self;
}
- (void)rightBarButtonItemAction{
    NSHomeMassageViewController *massageViewController = [[NSHomeMassageViewController alloc] init];
    [self.navigationController pushViewController:massageViewController  animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *allMemberViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allMemberViewAction)];
    [self.allMemberView addGestureRecognizer:allMemberViewTap];
    
    UITapGestureRecognizer *loveViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loveViewAction)];
    [self.loveView addGestureRecognizer:loveViewTap];
    
    UITapGestureRecognizer *feedBackViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(feedBackViewAction)];
    [self.feedBackView addGestureRecognizer:feedBackViewTap];
    
    UITapGestureRecognizer *userHelpViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userHelpViewAction)];
    [self.userHelpView addGestureRecognizer:userHelpViewTap];
    
    UITapGestureRecognizer *PhoneViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PhoneViewAction)];
    [self.PhoneView addGestureRecognizer:PhoneViewTap];
}

//家庭成员
- (void)allMemberViewAction{
    NSAllMemberViewController *AllMemberViewController = [NSAllMemberViewController new];
    [self.navigationController pushViewController:AllMemberViewController animated:YES];
}

//喜欢指南猫
- (void)loveViewAction{
    [self alertView];
}

//意见反馈
- (void)feedBackViewAction{
    NSfeedBackViewController *feedBackViewController = [NSfeedBackViewController new];
    [self.navigationController pushViewController:feedBackViewController animated:YES];
}

//用户帮助
- (void)userHelpViewAction{
    NSHelpViewController *HelpViewController = [NSHelpViewController new];
    [self.navigationController pushViewController:HelpViewController animated:YES];
}

//客服电话
- (void)PhoneViewAction{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"是否拨打电话" message:@"4006630799" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.delegate = self;
    alerView.tag = 100;
    [alerView show];
}
- (void)alertView{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:nil cancelButtonTitle:@"喜欢" otherButtonTitles:@"不喜欢", nil];
    [alertView show];
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
        }else if (buttonIndex == 1){
            NSString *phoneCall = [NSString stringWithFormat:@"tel:%@",@"4006630799"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCall]];
        }
    }
}
@end
