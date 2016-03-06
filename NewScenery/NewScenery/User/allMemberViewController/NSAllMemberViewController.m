//
//  NSAllMemberViewController.m
//  NewScenery
//
//  Created by mac on 16/2/17.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSAllMemberViewController.h"
#import "NSHTTPTool.h"
#import "NSAllMemberCell.h"
#import "NSAllMemberDetalViewController.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

static NSString *NSAllMemberCellID = @"NSAllMemberCell";

@interface NSAllMemberViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong)UIView *coverView;
@end

@implementation NSAllMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getNetDatas];
}

- (void)initUI{
    self.dataArray = [NSMutableArray new];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:NSAllMemberCellID bundle:nil] forCellReuseIdentifier:NSAllMemberCellID];
    self.navigationItem.title = @"家族成员";
    //创建蒙版view
    self.coverView = [[UIView alloc] initWithFrame:self.view.frame];
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kWidth/2.0-25, KHeight/2.0-25, 50, 50)];
    
    juhua.backgroundColor = [UIColor lightGrayColor];
    [juhua startAnimating];
    [self.coverView addSubview:juhua];
}
- (void)getNetDatas{
    [NSHTTPTool AllMemberGetNetDatas:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.coverView.hidden = YES;
            [self.tableView reloadData];
        });
    } error:^(NSError *error) {
        self.coverView.hidden = NO;
        NSLog(@"AllMemberGetNetDatas--->%@",error);
    }];
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
    if (self.dataArray.count == 0) {
        return 0;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAllMemberCell *allMemberCell = [tableView dequeueReusableCellWithIdentifier:NSAllMemberCellID];
    NSAllMemberModel *allMemberModel = self.dataArray[indexPath.row];
    [allMemberCell fullCellWithNSAllMemberModel:allMemberModel];
    return allMemberCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSAllMemberModel *allMemberModel = self.dataArray[indexPath.row];
    NSAllMemberDetalViewController *AllMemberDetalViewController = [NSAllMemberDetalViewController new];
    AllMemberDetalViewController.appID = allMemberModel.appid;
    AllMemberDetalViewController.titleStr = allMemberModel.title;
    [self.navigationController pushViewController:AllMemberDetalViewController animated:YES];
}
@end
