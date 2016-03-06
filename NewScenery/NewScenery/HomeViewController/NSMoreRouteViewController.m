//
//  NSMoreRouteViewController.m
//  NewScenery
//
//  Created by mac on 16/1/16.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSMoreRouteViewController.h"
#import "NSHeaderFile.h"
#import "NSRouteCell.h"
#import "NSHTTPTool.h"
#import "UIImageView+WebCache.h"
#import "NSRouteInfoViewController.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

static NSString *RouteCellID = @"NSRouteCell";
@interface NSMoreRouteViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *coverView;

@end

@implementation NSMoreRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self getNetDatas];
}
- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray new];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 346;
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:RouteCellID bundle:nil] forCellReuseIdentifier:RouteCellID];
    [self.view addSubview:self.tableView];
  
    //自定义navigationBar
    UIView *navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navigationBarView.backgroundColor = [UIColor clearColor];
    UIImageView *tabbarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    tabbarImageView.image = [UIImage imageNamed:@"shawdowHead"];
    tabbarImageView.alpha = 0.5;
    tabbarImageView.userInteractionEnabled = YES;
    [navigationBarView addSubview:tabbarImageView];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    [button setImage:[UIImage imageNamed:@"routeBack"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [tabbarImageView addSubview:button];
    [self.view addSubview:navigationBarView];
    
    //创建蒙版view
    self.coverView = [[UIView alloc] initWithFrame:self.view.frame];
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kWidth/2.0-25, KHeight/2.0-25, 50, 50)];
    
    juhua.backgroundColor = [UIColor lightGrayColor];
    [juhua startAnimating];
    [self.coverView addSubview:juhua];
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)getNetDatas{
    [NSHTTPTool SpecialRouteListGetNetDatas:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.tableHeaderView = [self tableHeaderViewWithModel:self.dataArray[0]];
             self.coverView.hidden = YES;
            [self.tableView reloadData];
        });

    } special_id:self.special_id error:^(NSError *error) {
         NSLog(@"MoreRouteInfoGetNetData--------->>%@",error);
        self.coverView.hidden = NO;
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = self.navigationBarHid;
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark -UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count-1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSRouteCell *cell = [tableView dequeueReusableCellWithIdentifier:RouteCellID];
    NSMoreRouteListModel *model = self.dataArray[indexPath.row+1];
    [cell fullCellWithNSMoreRouteListModel:model];
    return cell;
}
- (UIView *)tableHeaderViewWithModel:(NSMoreRouteBannerModel *)model{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 480)];
    tableHeaderView.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 230)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    [tableHeaderView addSubview:imageView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 250, self.view.frame.size.width, 21)];
    title.text = model.title;
    title.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    title.font = [UIFont systemFontOfSize:15];
    [tableHeaderView addSubview:title];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 291, self.view.frame.size.width-30, 189)];
    descLabel.backgroundColor = [UIColor whiteColor];
    descLabel.text = model.desc;
    descLabel.font = [UIFont systemFontOfSize:14];
    descLabel.textColor = [UIColor lightGrayColor];
    descLabel.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1];
    descLabel.numberOfLines = 0;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:descLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:12];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, descLabel.text.length)];
    descLabel.attributedText = attributedString;
    //调节高度
//    CGSize size = CGSizeMake(self.view.frame.size.width-30, 500000);
//    CGSize labelSize = [descLabel sizeThatFits:size];
//    descLabel.frame.size = labelSize;
    [tableHeaderView addSubview:descLabel];
    return tableHeaderView;
}
//点击cell跳到具体页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSRouteInfoViewController *routeInfoViewController = [NSRouteInfoViewController new];
    NSMoreRouteListModel *model = self.dataArray[indexPath.row+1];
    routeInfoViewController.routeID = model.data_id;
    [self.navigationController pushViewController:routeInfoViewController animated:YES];
}
@end
