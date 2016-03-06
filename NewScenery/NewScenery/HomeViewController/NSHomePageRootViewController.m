//
//  NSHomePageRootViewController.m
//  NewScenery
//
//  Created by mac on 16/1/12.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSHomePageRootViewController.h"
#import "NSHTTPTool.h"
#import "NSDesignerCell.h"
#import "NSRouteCell.h"
#import "NSBannerCell.h"
#import "NSHeaderFile.h"

#import "NSSearchResuktViewController.h"
#import "NSHomeMassageViewController.h"
#import "NSBeginCustomizedViewController.h"
#import "NSQuestOfCustomViewController.h"
#import "NSMoreDesignerViewController.h"
#import "NSMoreRouteViewController.h"
#import "NSDesignersInfoViewController.h"
#import "NSRouteInfoViewController.h"
#import "NSPhoneServiceViewController.h"
#import "NSDoorToDoorViewController.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
static NSString *DesignerCellID = @"NSDesignerCell";
static NSString *RouteCellID = @"NSRouteCell";
static NSString *BannerCellID = @"NSBannerCell";

@interface NSHomePageRootViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)NSMutableArray *bannerDataArray;
@property (nonatomic, strong)NSMutableArray *designerDataArray;
@property (nonatomic, strong)NSMutableArray *routeListDataArray;

@property (nonatomic, strong)UIView *begView;
@property (nonatomic, strong)UIView *searchView;
@property (nonatomic, strong)UIView *searchBarView;
@property (nonatomic, assign)BOOL isIncrease ;
@property (nonatomic, strong)UIView *coverView;

@end

@implementation NSHomePageRootViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"home"] selectedImage:[UIImage imageNamed:@"homeHL"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getNetDatas];
}
- (void)initUI
{
    self.bannerDataArray = [NSMutableArray array];
    self.designerDataArray = [NSMutableArray array];
    self.routeListDataArray = [NSMutableArray array];
    
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    self.tabelView.tableFooterView = [[UIView alloc] init];
    self.tabelView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.tabelView registerNib:[UINib nibWithNibName:DesignerCellID bundle:nil] forCellReuseIdentifier:DesignerCellID];
    [self.tabelView registerNib:[UINib nibWithNibName:RouteCellID bundle:nil] forCellReuseIdentifier:RouteCellID];
    [self.tabelView registerNib:[UINib nibWithNibName:BannerCellID bundle:nil] forCellReuseIdentifier:BannerCellID];
    [self.view addSubview:self.tabelView];
    
   //------------------------init搜索---------------
    [self SearchBarView];
    
    //-----------------建立消息中心，通过消息内容跳到相应的页面
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(DoSomThingByReceiveMassgeFromBanner:) name:@"bannerMassage" object:nil];
    [center addObserver:self selector:@selector(DoSomThingByReceiveMassgeFromDesigner:) name:@"ServiceMassage" object:nil];
    
    //创建蒙版view
    self.coverView = [[UIView alloc] initWithFrame:self.view.frame];
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(kWidth/2.0-25, KHeight/2.0-25, 50, 50)];
   
    juhua.backgroundColor = [UIColor lightGrayColor];
    [juhua startAnimating];
    [self.coverView addSubview:juhua];
}

//自定义searchView
- (void)SearchBarView{
    self.searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kWidth, self.navigationController.navigationBar.bounds.size.height+20)];
    self.searchBarView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    //massageTap
    self.begView = [[UIView alloc] initWithFrame:CGRectMake(kWidth-55,28, 65, self.navigationController.navigationBar.bounds.size.height-18)];
    self.begView.layer.cornerRadius = 12;
    self.begView.layer.masksToBounds = YES;
    self.begView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    UIImageView *massageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 18, 18)];
    massageImageView.image = [UIImage imageNamed:@"message"];
    [self.begView addSubview:massageImageView];
    UILabel *massageLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 3, 30, 21)];
    massageLabel.text = @"消息";
    massageLabel.font = [UIFont systemFontOfSize:12];
    massageLabel.textColor = [UIColor whiteColor];
    [self.begView addSubview:massageLabel];
    UITapGestureRecognizer *begTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(massgaeAction)];
    [self.begView addGestureRecognizer:begTap];
    [self.searchBarView addSubview:self.begView];
    //searchView
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(10, 28, kWidth-75, self.navigationController.navigationBar.bounds.size.height-18)];
    self.searchView.layer.cornerRadius = 12;
    self.searchView.layer.masksToBounds = YES;
    self.searchView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction)];
    [self.searchView addGestureRecognizer:searchTap];
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 15, 15)];
    searchImageView.image = [UIImage imageNamed:@"homeSearch"];
    [self.searchView addSubview:searchImageView];
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, kWidth-150, 21)];
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.text = @"想去哪里？";
    titlelabel.font = [UIFont systemFontOfSize:13];
    [self.searchView addSubview:titlelabel];
    [self.searchBarView addSubview:self.searchView];
    [self.view addSubview:self.searchBarView];
}
//消息
- (void)massgaeAction{
    NSHomeMassageViewController *massageVC = [[NSHomeMassageViewController alloc] init];
    [self.navigationController pushViewController:massageVC animated:YES];
}
//搜索
- (void)searchAction{
    NSSearchResuktViewController *searchViewController = [[NSSearchResuktViewController alloc] init];
    [self.navigationController pushViewController:searchViewController animated:YES];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tabelView endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden  = YES;
}
- (void)getNetDatas{
    [NSHTTPTool HomeContentGetNetData:^(NSArray *bannerData, NSArray *designerData, NSArray *routeListData) {
        [self.bannerDataArray removeAllObjects];
        [self.designerDataArray removeAllObjects];
        [self.routeListDataArray removeAllObjects];
        
        [self.bannerDataArray addObjectsFromArray:bannerData];
        [self.designerDataArray addObjectsFromArray:designerData];
        [self.routeListDataArray addObjectsFromArray:routeListData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabelView reloadData];
            self.coverView.hidden = YES;
        });
    } error:^(NSError *error) {
        NSLog(@"HomeContentGetNetData-------->%@",error);
        self.coverView.hidden = NO;
    }];
}
#pragma mark - NSNotificationCenter
- (void)DoSomThingByReceiveMassgeFromBanner:(NSNotification *)notifi
{
    NSString  *keyWord = notifi.object;
    
    if ([keyWord isEqualToString:@"bannerTapAction"]| [keyWord isEqualToString:@"BeginCustomized"] ) {
        NSBeginCustomizedViewController *beginCustomizedVC = [[NSBeginCustomizedViewController alloc] init];
        [self.navigationController pushViewController:beginCustomizedVC animated:YES];
    }else if ([keyWord isEqualToString:@"QuestionClick"]|[keyWord isEqualToString:@"CustomizedClick"]|[keyWord isEqualToString:@"ParityClick"]|[keyWord isEqualToString:@"ElectronicTourGuideClick"]){
        NSQuestOfCustomViewController *qocVC = [[NSQuestOfCustomViewController alloc] init];
        [self.navigationController pushViewController:qocVC animated:YES];
    }
}
- (void)DoSomThingByReceiveMassgeFromDesigner:(NSNotification *)notifi
{
    NSArray *tmpArr = notifi.object;
    NSMoreDesigner *model = tmpArr[0];
    NSString *keyWord = tmpArr[1];
    if ([keyWord isEqualToString:@"canPhoneClick"]){
        if ([model.can_phone_service isEqualToString:@"1"]) {
            NSPhoneServiceViewController *phoneServiceViewController = [[NSPhoneServiceViewController alloc]init];
            phoneServiceViewController.designerID = model.data_id;
            phoneServiceViewController.designerType = model.designer_type;
            [self.navigationController pushViewController:phoneServiceViewController animated:YES];
        }else{
            [self alerText:@"该设计师当前不支持电话咨询"];
        }
    }else if ([keyWord isEqualToString:@"canDoorClick"]){
        if ([model.can_doortodoor isEqualToString:@"1"]) {
            NSDoorToDoorViewController *doorToDoorViewController = [NSDoorToDoorViewController new];
            doorToDoorViewController.designerID = model.data_id;
            doorToDoorViewController.designerType = model.designer_type;
            [self.navigationController pushViewController:doorToDoorViewController animated:YES];
        }else{
            [self alerText:@"该设计师当前不支持见面咨询"];
        }
    }else if ([keyWord isEqualToString:@"canServiceClick"]){
        if ([model.can_route_service isEqualToString:@"1"]) {
            NSBeginCustomizedViewController *beginCustomizedVC = [[NSBeginCustomizedViewController alloc] init];
            [self.navigationController pushViewController:beginCustomizedVC animated:YES];
        }else{
            [self alerText:@"该设计师当前不支持邀请定制"];
        }
    }
}
-(void)alerText:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
    [alert show];
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!(self.bannerDataArray.count&&self.designerDataArray.count&&self.routeListDataArray.count)) {
        return 0;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1){       
        return self.designerDataArray.count;
   
    }else{
        return self.routeListDataArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:BannerCellID];

        [cell fullCellWithBannerArray:self.bannerDataArray];
        return cell;
        
    }else if(indexPath.section == 1){
        NSDesignerCell *cell = [tableView dequeueReusableCellWithIdentifier:DesignerCellID];
        NSMoreDesigner *model = self.designerDataArray[indexPath.row];
        [cell fullCellWithMoreDesignerModel:model];
        return cell;
    }
    //section == 2;
    NSRouteCell *cell = [tableView dequeueReusableCellWithIdentifier:RouteCellID];
    NSMoreRouteListModel *more = self.routeListDataArray[indexPath.row];
    [cell fullCellWithNSMoreRouteListModel:more];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 458;
    }else if (indexPath.section == 1){
        return 412;
    }else{
        return 346;
    }
}

//段头段尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{   
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 28)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.tag = section;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MoreInfoAction:)];
    [headerView addGestureRecognizer:tap];
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 25, 25)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 150, 20)];
    label.font = [UIFont systemFontOfSize:13];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-50, 13, 50, 20)];
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor cyanColor];
    label1.text = @"更多＞";
    if (section == 1) {
        headerImageView.image = [UIImage imageNamed:@"defaultSectionTitleImage"];
        label.text = @"遇见旅行设计师";
    }else{
        headerImageView.image = [UIImage imageNamed:@"defaultRouteTitleImage"];
        label.text = @"查看样板路线";
    }
    [headerView addSubview:label1];
    [headerView addSubview:label];
    [headerView addSubview:headerImageView];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 44;
}

//点击cell跳到相应的页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tabelView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        NSMoreDesigner *model = self.designerDataArray[indexPath.row];
        NSDesignersInfoViewController *DIFVC = [[NSDesignersInfoViewController alloc] init];
        DIFVC.desinerID = model.data_id;
        [self.navigationController pushViewController:DIFVC animated:YES];
    }
    if (indexPath.section == 2) {
        NSMoreRouteListModel *model = self.routeListDataArray[indexPath.row];
        NSRouteInfoViewController *RIVC = [[NSRouteInfoViewController alloc] init];
        RIVC.routeID = model.data_id;
        [self.navigationController pushViewController:RIVC animated:YES];
    }
}
//点击段头跳到相应的页面
- (void)MoreInfoAction:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 1) {//更多设计者信息
        NSMoreDesignerViewController *MDVC = [[NSMoreDesignerViewController alloc] init];
        [self.navigationController pushViewController:MDVC animated:YES];
    }else{//更多路线信息
        NSMoreRouteViewController *MRVC = [[NSMoreRouteViewController alloc] init];
        NSBannerModel *model = self.bannerDataArray[0];
        MRVC.special_id = model.special_id;
        MRVC.navigationBarHid = YES;
        [self.navigationController pushViewController:MRVC animated:YES];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<0) {
        return;
    }
    static CGFloat tmpContentOffset_y = 0;
    float scale = scrollView.contentOffset.y / 380;
    if (scale>1) {
        scale = 1;
    }
    self.searchBarView.backgroundColor = [UIColor colorWithWhite:1 alpha:scale];
    self.begView.backgroundColor = [UIColor colorWithWhite:0.3+scale*0.5 alpha:scale*0.6+0.3];
     self.searchView.backgroundColor = [UIColor colorWithWhite:0.3+scale*0.5 alpha:scale*0.6+0.3];
    if (((tmpContentOffset_y - scrollView.contentOffset.y)<0)) {
        self.isIncrease = YES;
    }else{
        self.isIncrease = NO;
    }
    if (scrollView.contentOffset.y > 380&&self.isIncrease) {
        self.searchBarView.hidden = YES;
    }else if((scrollView.contentOffset.y <= 380.0)|!self.isIncrease){
        self.searchBarView.hidden = NO;
    }
    tmpContentOffset_y = scrollView.contentOffset.y;
}
@end
