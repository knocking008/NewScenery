//
//  NSRouteInfoViewController.m
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSRouteInfoViewController.h"
#import "NSHTTPTool.h"
#import "NSRouteTableHeaderView.h"
#import "NSRouteDayCell.h"
#import "NSRouteTrafficCell.h"
#import "NSHeaderForSection.h"
#import "NSPointInfoViewController.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

static NSString *RouteDayCellID = @"NSRouteDayCell";
static NSString *RouteTrafficCellID = @"NSRouteTrafficCell";
@interface NSRouteInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSRouteTableHeaderView *tableHeaderView;
@property (nonatomic, strong)UIView *coverView;
@property (nonatomic, assign)NSInteger route_desc_height;
@end

@implementation NSRouteInfoViewController

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
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:RouteDayCellID bundle:nil] forCellReuseIdentifier:RouteDayCellID];
    [self.tableView registerNib:[UINib nibWithNibName:RouteTrafficCellID bundle:nil] forCellReuseIdentifier:RouteTrafficCellID];
    
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
    
    //通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(changeHeaderViewHeight:) name:@"changeHeaderViewHeight" object:nil];
}

//改变HeaderView高度
- (void)changeHeaderViewHeight:(NSNotification *)notifi{
    NSRouteBaseInfoModel *RouteBaseInfoModel = [self.dataArray firstObject];
    self.route_desc_height = [NSRouteBaseInfoModel heightForLabelWith:RouteBaseInfoModel.route_desc];
    CGRect newHeaderViewFrame = self.tableHeaderView.frame;
    if ([notifi.object integerValue] != 0) {
        newHeaderViewFrame.size.height = newHeaderViewFrame.size.height+self.route_desc_height;
    }else{
        newHeaderViewFrame.size.height = newHeaderViewFrame.size.height-self.route_desc_height;
        self.route_desc_height = 0;
    }
    self.tableHeaderView.frame = newHeaderViewFrame;
    self.tableView.tableHeaderView = self.tableHeaderView;
}


//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)getNetDatas{
    [NSHTTPTool MoreInfoForRouteGetNetData:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"NSRouteTableHeaderView" owner:nil options:nil].firstObject;
            self.tableView.tableHeaderView = self.tableHeaderView;
            [self.tableHeaderView fullViewWithNSRouteBaseInfoModel:self.dataArray[0]];
           self.coverView.hidden = YES;
            [self.tableView reloadData];
        });
    } routeID:self.routeID error:^(NSError *error) {
        self.coverView.hidden = NO;
        NSLog(@"MoreInfoForRouteGetNetData------>>%@",error);
    }];
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray&&self.dataArray.count!=0){
        NSArray *tmpArr = self.dataArray[1];
     
        
        return tmpArr.count;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray&&self.dataArray.count!=0) {
        NSArray *sectionArr = self.dataArray[1];
        NSArray *rowArr = sectionArr[section];
        return rowArr.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!(self.dataArray&&self.dataArray.count!=0)) {
        return nil;
    }
    NSArray *sectionArr = self.dataArray[1];
    NSArray *rowArr = sectionArr[indexPath.section];
    if ([rowArr[indexPath.row] isKindOfClass:[NSRouteDaysModel class]]) {
        NSRouteDayCell *cell = [tableView dequeueReusableCellWithIdentifier:RouteDayCellID];
        [cell fullCellWithNSRouteDaysModel:rowArr[indexPath.row]];
        return cell;
    }else if([rowArr[indexPath.row] isKindOfClass:[NSRouteTrafficModel class]]){
        NSRouteTrafficCell *cell = [tableView dequeueReusableCellWithIdentifier:RouteTrafficCellID];
        [cell fullCellWithNSRouteTrafficModel:rowArr[indexPath.row]];
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"section%ld ---- row %ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSHeaderForSection *headeView = [[NSBundle mainBundle] loadNibNamed:@"NSHeaderForSection" owner:nil options:nil].firstObject;
    NSArray *tmpArr = [self.dataArray lastObject];
    headeView.layer.borderWidth = 0.3;
    headeView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [headeView fullViewWithNSRoute_overviewModel:tmpArr[section]];
    return headeView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSArray *sectionArr = self.dataArray[1];
    NSArray *rowArr = sectionArr[indexPath.section];
    if ([rowArr[indexPath.row] isKindOfClass:[NSRouteDaysModel class]]) {
        NSRouteDaysModel *routeDaysModel = rowArr[indexPath.row];
        return [NSRouteDaysModel heightForCellWith:routeDaysModel.daliy_note];
    }else if ([rowArr[indexPath.row] isKindOfClass:[NSRouteTrafficModel class]]){
        NSRouteTrafficModel *RouteTrafficModel = rowArr[indexPath.row];
        return [NSRouteTrafficModel heightForCellWith:RouteTrafficModel.daliy_note];
    }
    return 160;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *sectionArr = self.dataArray[1];
    NSArray *rowArr = sectionArr[indexPath.section];
    if ([rowArr[indexPath.row] isKindOfClass:[NSRouteDaysModel class]]){
        NSRouteDaysModel *RouteDaysModel = rowArr[indexPath.row];
        NSPointInfoViewController *PointInfoViewController = [NSPointInfoViewController new];
        PointInfoViewController.point_id = RouteDaysModel.point_id;
        [self.navigationController pushViewController:PointInfoViewController animated:YES];
    }

}
@end
