//
//  NSHelpViewController.m
//  NewScenery
//
//  Created by mac on 16/2/17.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSHelpViewController.h"
#import "NSUserHelpCell.h"

static NSString *NSUserHelpCellID = @"NSUserHelpCell";
@interface NSHelpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *titleArray;
@property (nonatomic, strong)NSMutableArray *heigthForCellArray;
@property (nonatomic, strong)NSMutableArray *hiddenArray;

@property (nonatomic, assign)BOOL isDesignerTap;
@property (nonatomic, assign)BOOL isDateTap;
@property (nonatomic, assign)BOOL isMyTap;
@property (nonatomic, assign)BOOL isMessageTap;

@end

@implementation NSHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatas];
    [self initUI];
}
- (void)initUI{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSUserHelpCellID bundle:nil] forCellReuseIdentifier:NSUserHelpCellID];
    self.navigationItem.title = @"使用帮助";
    //通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(changeLabelHeightAction:) name:@"tapAction" object:nil];
}
- (void)initDatas{
    self.dataArray = [NSMutableArray new];
    self.heigthForCellArray = [NSMutableArray arrayWithObjects:@(38),@(38),@(38),@(38), nil];
    self.hiddenArray = [NSMutableArray arrayWithObjects:@(1),@(1),@(1),@(1), nil];
    NSString *designer = @"答：NewScenery平台上得旅行设计师，是由旅行达人目的地导游组成，他们都是在自营目的地居住过，或有多次深度旅游经验的人。\nNewScenery会对他们的资质进行严格的审查，同时您也可以查看设计师的个人信息及服务评价";
    NSString *date = @"答：当您出行前确认好旅行设计师为您定制的路线后，您的路线将会自动生成日程页，在这里您可以方便的查看每个景点、酒店、用餐、交通等详细信息。它，就是您的电子导游。";
    NSString *my = @"答：您的订单和其他信息都会出现在这里，也希望您支持NewScenery，给我们一个好评~助力我们打造一个更加好得旅行平台";
    NSString *massage = @"答：在这里你可以查看与设计师的在线即时消息，NewScenery活动通知，以及系统通知。在您出行中，小喵会作为您的在线旅行顾问，可以对您在出行中得问题进行解答";
    [self.dataArray addObject:designer];
    [self.dataArray addObject:date];
    [self.dataArray addObject:my];
    [self.dataArray addObject:massage];
    self.titleArray = [NSMutableArray arrayWithObjects:@"1.设计师由谁组成",@"2.【日程】是什么？",@"3.【我的】有什么？",@"4.【消息】里有什么？", nil];
}
- (void)changeLabelHeightAction:(NSNotification *)notifi{
    
    if ([notifi.object isEqualToString:self.titleArray[0]]) {
        self.isDesignerTap = !self.isDesignerTap;
        if (self.isDesignerTap) {
            [self.heigthForCellArray replaceObjectAtIndex:0 withObject:@([self heightForLabel:self.dataArray[0]]+38)];
            [self.hiddenArray replaceObjectAtIndex:0 withObject:@(0)];
        }else{
            [self.heigthForCellArray replaceObjectAtIndex:0 withObject:@(38)];
            [self.hiddenArray replaceObjectAtIndex:0 withObject:@(1)];
        }
    }else if ([notifi.object isEqualToString:self.titleArray[1]]){
        self.isDateTap = !self.isDateTap;
        if (self.isDateTap) {
            [self.hiddenArray replaceObjectAtIndex:1 withObject:@(0)];
            [self.heigthForCellArray replaceObjectAtIndex:1 withObject:@([self heightForLabel:self.dataArray[1]]+38)];
        }else{
             [self.heigthForCellArray replaceObjectAtIndex:1 withObject:@(38)];
            [self.hiddenArray replaceObjectAtIndex:1 withObject:@(1)];
        }
    }else if ([notifi.object isEqualToString:self.titleArray[2]]){
        self.isMyTap = !self.isMyTap;
        if (self.isMyTap) {
            [self.hiddenArray replaceObjectAtIndex:2 withObject:@(0)];
            [self.heigthForCellArray replaceObjectAtIndex:2 withObject:@([self heightForLabel:self.dataArray[2]]+38)];
        }else{
             [self.heigthForCellArray replaceObjectAtIndex:2 withObject:@(38)];
            [self.hiddenArray replaceObjectAtIndex:2 withObject:@(1)];
        }
    }else if ([notifi.object isEqualToString:self.titleArray[3]]){
        self.isMessageTap = !self.isMessageTap;
        if (self.isMessageTap) {
            [self.hiddenArray replaceObjectAtIndex:3 withObject:@(0)];
            [self.heigthForCellArray replaceObjectAtIndex:3 withObject:@([self heightForLabel:self.dataArray[3]]+38)];
        }else{
             [self.heigthForCellArray replaceObjectAtIndex:3 withObject:@(38)];
            [self.hiddenArray replaceObjectAtIndex:3 withObject:@(1)];
        }
    }
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (NSInteger)heightForLabel:(NSString *)text{
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    bounds=[text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-15, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height+21;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 0) {
        return nil;
    }
    NSUserHelpCell *userHelpCell = [tableView dequeueReusableCellWithIdentifier:NSUserHelpCellID];
    [userHelpCell fullCellWith:self.titleArray[indexPath.row] text:self.dataArray[indexPath.row] textHidden:[self.hiddenArray[indexPath.row] intValue]];
    
    return userHelpCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.heigthForCellArray[indexPath.row] integerValue];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
