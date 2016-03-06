//
//  NSCalendarRootViewController.m
//  NewScenery
//
//  Created by mac on 16/1/11.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSCalendarRootViewController.h"
#import "NSHTTPTool.h"
#import "NSHeaderFile.h"
#import "NSCalendarPointCell.h"
#import "NSCalendarTrafficPlanceCell.h"
#import "NSCalendarTrafficTrainCell.h"
#import "NSCalendarTrafficBusCell.h"
#import "NSCalendarTrafficWalkCell.h"
#import "NSCalendarTrafficPointCell.h"
#import "NSPointInfoViewController.h"
#import "NSNetDatasErrorCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height


static NSString *NSNetDatasErrorCellID = @"NSNetDatasErrorCell";
static NSString *NSCalendarPointCellID = @"NSCalendarPointCell";

static NSString *NSCalendarTrafficPlanceCellID = @"NSCalendarTrafficPlanceCell";
static NSString *NSCalendarTrafficTrainCellID = @"NSCalendarTrafficTrainCell";
static NSString *NSCalendarTrafficBusCellID = @"NSCalendarTrafficBusCell";
static NSString *NSCalendarTrafficWalkCellID = @"NSCalendarTrafficWalkCell";
static NSString *NSCalendarTrafficPointCellID = @"NSCalendarTrafficPointCell";

@interface NSCalendarRootViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *coverView;
@property (nonatomic, strong)NSString *phoneStr;
@property (nonatomic, strong)NSMutableArray *errorArray;
@property (nonatomic, assign)BOOL SystemError;

@end

@implementation NSCalendarRootViewController
- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"日程" image:[UIImage imageNamed:@"calendar"] selectedImage:[UIImage imageNamed:@"calendar@2xHL"]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getNetDatas];
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.errorArray = [NSMutableArray arrayWithObjects:@"routeDayOne",@"routeDayTwo",@"routeDayThree",@"routeDayFour", nil];
    self.navigationItem.title = @"日程向导";
    self.dataArray = [NSMutableArray new];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSNetDatasErrorCellID bundle:nil] forCellReuseIdentifier:NSNetDatasErrorCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSCalendarPointCellID bundle:nil] forCellReuseIdentifier:NSCalendarPointCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSCalendarTrafficPlanceCellID bundle:nil] forCellReuseIdentifier:NSCalendarTrafficPlanceCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSCalendarTrafficTrainCellID bundle:nil] forCellReuseIdentifier:NSCalendarTrafficTrainCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSCalendarTrafficBusCellID bundle:nil] forCellReuseIdentifier:NSCalendarTrafficBusCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSCalendarTrafficWalkCellID bundle:nil] forCellReuseIdentifier:NSCalendarTrafficWalkCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSCalendarTrafficPointCellID bundle:nil] forCellReuseIdentifier:NSCalendarTrafficPointCellID];
    [self.view addSubview:self.tableView];
    
    //创建蒙版view
    self.coverView = [[UIView alloc] initWithFrame:self.view.frame];
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kWidth/2-25, KHeight/2-25, 50, 50)];
    
    juhua.backgroundColor = [UIColor lightGrayColor];
    [juhua startAnimating];
    [self.coverView addSubview:juhua];
    
    //建立消息中心
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(alerText:) name:@"phoneStr" object:nil];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}
- (void)getNetDatas{
    [NSHTTPTool DaliysByRouteGetNetDatas:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.SystemError = NO;
            self.coverView.hidden = YES;
            [self.tableView reloadData];
        });
        
    } error:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.SystemError= YES;
            self.coverView.hidden = YES;
            [self.tableView reloadData];
        });
        NSLog(@"DaliysByRouteGetNetDatas------>>%@",error);
    }];
}

-(void)alerText:(NSNotification *)notifi{
    self.phoneStr = notifi.object;
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"是否拨打电话" message:notifi.object delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerView.delegate = self;
    [alerView show];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.SystemError) {
        return 1;
    }
    if (self.dataArray.count == 0) {
        return 0;
    }
    return self.dataArray.count-1;
}
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.SystemError) {
        return 4;
    }
    if (self.dataArray.count == 0) {
        return 0;
    }
    NSArray *sectionArr = self.dataArray[section+1];
    return sectionArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.SystemError) {
        NSNetDatasErrorCell *NetDatasErrorCell = [tableView dequeueReusableCellWithIdentifier:NSNetDatasErrorCellID];
        [NetDatasErrorCell fullCellWith:self.errorArray[indexPath.row]];
        return NetDatasErrorCell;
    }
    NSArray *section = self.dataArray[indexPath.section+1];
    if ([section[indexPath.row] isKindOfClass:[NSDaliysPointModel class]]) {
        NSCalendarPointCell *pointCell = [tableView dequeueReusableCellWithIdentifier:NSCalendarPointCellID];
        NSDaliysPointModel *daliysPointModel = section[indexPath.row];
        [pointCell fullCellWithNSDaliysPointModel:daliysPointModel];
        return pointCell;
    }else if ([section[indexPath.row] isKindOfClass:[NSDaliysTrafficModel class]]){
        NSDaliysTrafficModel *daliysTrafficModel = section[indexPath.row];
        if ([daliysTrafficModel.traffic_type isEqualToString:@"1"]) {//飞机类型
            NSCalendarTrafficPlanceCell *CalendarTrafficPlanceCell = [tableView dequeueReusableCellWithIdentifier:NSCalendarTrafficPlanceCellID];
            [CalendarTrafficPlanceCell fullCellWithNSDaliysTrafficModel:daliysTrafficModel];
            return CalendarTrafficPlanceCell;
        }else if([daliysTrafficModel.traffic_type isEqualToString:@"3"]){//地铁
            NSCalendarTrafficTrainCell *CalendarTrafficTrainCell = [tableView dequeueReusableCellWithIdentifier:NSCalendarTrafficTrainCellID];
            [CalendarTrafficTrainCell fullCellWithNSDaliysTrafficModel:daliysTrafficModel];
            return CalendarTrafficTrainCell;
        }else if([daliysTrafficModel.traffic_type isEqualToString:@"4"]){//公交
            NSCalendarTrafficBusCell *CalendarTrafficBusCell = [tableView dequeueReusableCellWithIdentifier:NSCalendarTrafficBusCellID];
            [CalendarTrafficBusCell fullCellWithNSDaliysTrafficModel:daliysTrafficModel];
            return CalendarTrafficBusCell;
        }else if([daliysTrafficModel.traffic_type isEqualToString:@"10"]){//步行
            NSCalendarTrafficWalkCell *CalendarTrafficWalkCell = [tableView dequeueReusableCellWithIdentifier:NSCalendarTrafficWalkCellID];
            [CalendarTrafficWalkCell fullCellWithNSDaliysTrafficModel:daliysTrafficModel];
            return CalendarTrafficWalkCell;
        }else if([daliysTrafficModel.traffic_type isEqualToString:@"11"]){//轮船
            NSCalendarTrafficPointCell *CalendarTrafficPointCell = [tableView dequeueReusableCellWithIdentifier:NSCalendarTrafficPointCellID];
            [CalendarTrafficPointCell fullCellWithNSDaliysTrafficModel:daliysTrafficModel];
            return CalendarTrafficPointCell;
        }
    }
    return nil;
}
//cell高度设置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.SystemError) {
        return 350;
    }
    NSArray *section = self.dataArray[indexPath.section+1];
    if ([section[indexPath.row] isKindOfClass:[NSDaliysPointModel class]]) {
        return 424;
    }else if ([section[indexPath.row] isKindOfClass:[NSDaliysTrafficModel class]]){
        NSDaliysTrafficModel *daliysTrafficModel = section[indexPath.row];
        if ([daliysTrafficModel.traffic_type isEqualToString:@"1"]|[daliysTrafficModel.traffic_type isEqualToString:@"11"]) {
            return 300;
        }else{
            return 350;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.SystemError) {
        return;
    }
    NSArray *section = self.dataArray[indexPath.section+1];
    if ([section[indexPath.row] isKindOfClass:[NSDaliysPointModel class]]) {
        NSDaliysPointModel *model = section[indexPath.row];
        NSPointInfoViewController *pointInfoViewController = [[NSPointInfoViewController alloc] init];
        pointInfoViewController.point_id = model.point_id;
        [self.navigationController pushViewController:pointInfoViewController animated:YES];
    }
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
    }else if (buttonIndex == 1){
        NSString *phoneCall = [NSString stringWithFormat:@"tel:%@",self.phoneStr];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneCall]];
    }
}

@end
