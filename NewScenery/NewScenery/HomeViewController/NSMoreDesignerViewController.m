//
//  NSMoreDesignerViewController.m
//  NewScenery
//
//  Created by mac on 16/1/15.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSMoreDesignerViewController.h"
#import "NSHTTPTool.h"
#import "NSDesignerCell.h"
#import "MJRefresh.h"
#import "NSDesignersInfoViewController.h"
#import "NSHeaderFile.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

static NSString *DesignerCellID = @"NSDesignerCell";
@interface NSMoreDesignerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tabbelView;
@property (nonatomic, assign)int pageIndex;
@property (nonatomic, strong)UIView *coverView;

@end

@implementation NSMoreDesignerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getNetDatas:YES];
}
- (void)initUI{
    self.dataArray = [NSMutableArray new];
    self.tabbelView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tabbelView.dataSource = self;
    self.tabbelView.delegate = self;
    self.tabbelView.rowHeight = 430;
    self.tabbelView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    [self.tabbelView registerNib:[UINib nibWithNibName:DesignerCellID bundle:nil] forCellReuseIdentifier:DesignerCellID];
    [self.view addSubview:self.tabbelView];
    
    __weak typeof(self) beself = self;
    [self.tabbelView addHeaderWithCallback:^{
        [beself getNetDatas:YES];
    }];
    [self.tabbelView addFooterWithCallback:^{
        [beself getNetDatas:NO];
    }];
    //创建蒙版view
    self.coverView = [[UIView alloc] initWithFrame:self.view.frame];
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kWidth/2.0-25, KHeight/2.0-25, 50, 50)];
    
    juhua.backgroundColor = [UIColor lightGrayColor];
    [juhua startAnimating];
    [self.coverView addSubview:juhua];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"设计师";
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)getNetDatas:(BOOL)isHeader{
    if (isHeader) {
        self.pageIndex = 1;
    }
    [NSHTTPTool MoreDesignerGetNetData:^(NSArray *data) {
        if (isHeader) {
            [self.dataArray removeAllObjects];
            [self.tabbelView headerEndRefreshing];
        }else{
            [self.tabbelView footerEndRefreshing];
        }
        [self.dataArray addObjectsFromArray:data];
        dispatch_async(dispatch_get_main_queue(), ^{
             self.coverView.hidden = YES;
            [self.tabbelView reloadData];
        });
        self.pageIndex++;
    } page:self.pageIndex error:^(NSError *error) {
        if (isHeader) {
            [self.tabbelView headerEndRefreshing];
        }else{
            [self.tabbelView footerEndRefreshing];
        }
        self.coverView.hidden = NO;
        NSLog(@"MoreDesignerInfoGetNetData---->%@",error);
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDesignerCell *cell = [tableView dequeueReusableCellWithIdentifier:DesignerCellID];
    NSMoreDesigner *model = self.dataArray[indexPath.row];
    [cell fullCellWithMoreDesignerModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDesignersInfoViewController *designersInfoViewController = [[NSDesignersInfoViewController alloc] init];
    NSMoreDesigner *moreDesigner = self.dataArray[indexPath.row];
    designersInfoViewController.desinerID = moreDesigner.data_id;
    [self.navigationController pushViewController:designersInfoViewController animated:YES];
}
@end
