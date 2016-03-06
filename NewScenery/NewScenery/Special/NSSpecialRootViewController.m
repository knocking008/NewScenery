//
//  NSSpecialRootViewController.m
//  NewScenery
//
//  Created by mac on 16/1/11.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSSpecialRootViewController.h"
#import "NSHTTPTool.h"
#import "NSSpecialCell.h"
#import "NSHeaderFile.h"
#import "NSMoreRouteViewController.h"
#import "NSMorePointListViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
static NSString *NSSpecialCellID = @"NSSpecialCell";
@interface NSSpecialRootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)UIView *coverView;
@end

@implementation NSSpecialRootViewController
- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"灵感" image:[UIImage imageNamed:@"routeSpecial"] selectedImage:[UIImage imageNamed:@"routeSpecialHL"]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getNetDatas];
}
- (void)initUI{
    self.navigationItem.title = @"旅行灵感";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor darkGrayColor]};
    self.dataArray = [NSMutableArray new];
    self.tabelView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tabelView.dataSource = self;
    self.tabelView.delegate = self;
    self.tabelView.rowHeight = 150;
    self.tabelView.tableFooterView = [UIView new];
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabelView];
    [self.tabelView registerNib:[UINib nibWithNibName:NSSpecialCellID bundle:nil] forCellReuseIdentifier:NSSpecialCellID];
    //创建蒙版view
    self.coverView = [[UIView alloc] initWithFrame:self.view.frame];
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kWidth/2-25, KHeight/2-25, 50, 50)];
    
    juhua.backgroundColor = [UIColor lightGrayColor];
    [juhua startAnimating];
    [self.coverView addSubview:juhua];
}
- (void)getNetDatas{
    [NSHTTPTool SpecialGetNetDatas:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.coverView.hidden = YES;
            [self.tabelView reloadData];
            
        });
    } error:^(NSError *error) {
        NSLog(@"SpecialGetNetDatas------->>>%@",error);
    }];
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSSpecialCell *cell = [tableView dequeueReusableCellWithIdentifier:NSSpecialCellID];
    NSGetspecialModel *model = self.dataArray[indexPath.row];
    [cell fullCellWithNSGetspecialModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSGetspecialModel *model = self.dataArray[indexPath.row];
       if ([model.type isEqualToString:@"5"]) { //进入更多路线列表
        NSMoreRouteViewController *specialdetailViewController = [[NSMoreRouteViewController alloc] init];
        specialdetailViewController.special_id = model.special_id;
           specialdetailViewController.navigationBarHid = NO;
        [self.navigationController pushViewController:specialdetailViewController animated:YES];
    }else if([model.type isEqualToString:@"3"]){//进入更多地点列表
        NSMorePointListViewController *morePointListViewController = [[NSMorePointListViewController alloc] init];
        morePointListViewController.special_id = model.special_id;
        [self.navigationController pushViewController:morePointListViewController animated:YES];
    }
   
    
}
@end
