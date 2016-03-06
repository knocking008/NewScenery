//
//  NSHomeMassageViewController.m
//  NewScenery
//
//  Created by mac on 16/1/13.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSHomeMassageViewController.h"
#import "NSHomeMassageTableViewCell.h"
#import "NSMassageModel.h"
#import "NSActionViewController.h"
#import "NSNotifiViewController.h"

static NSString *HomeMassageID = @"NSHomeMassageTableViewCell";
@interface NSHomeMassageViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation NSHomeMassageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    [self initUI];
    [self InitData];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"会话列表";
    self.dataArray = [NSMutableArray new];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.rowHeight = 100;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:HomeMassageID bundle:nil] forCellReuseIdentifier:HomeMassageID];
}
- (void)InitData
{
    NSArray *imageArray = @[@"praise",@"feedBack"];
    NSArray *actionArray = @[@"指南猫活动",@"小喵"];
    NSArray *descArray = @[@"[演员招募]指南猫微电影寻找下一位旅行",@"暂无通知"];
    NSArray *data = @[@"01-08",@"20:22"];
    for (int i = 0; i < 2; i++) {
         NSMassageModel *model = [[NSMassageModel alloc] init];
        model.iconImageName = imageArray[i];
        model.actionTitle = actionArray[i];
        model.desc = descArray[i];
        model.date = data[i];
        [self.dataArray addObject:model];
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSHomeMassageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeMassageID];
    NSMassageModel *model = self.dataArray[indexPath.row];
    
    [cell fullCellWith:model];
    return cell;
}

//跳到下个页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        NSActionViewController *actionVC = [[NSActionViewController alloc] init];
        [self.navigationController pushViewController:actionVC animated:YES];
    }else{
        NSNotifiViewController *notifiVC = [[NSNotifiViewController alloc] init];
        [self.navigationController pushViewController:notifiVC animated:YES];
    }
    
    
}
@end
