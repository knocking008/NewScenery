//
//  NSPointInfoViewController.m
//  NewScenery
//
//  Created by mac on 16/1/21.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSPointInfoViewController.h"
#import "NSHTTPTool.h"
#import "NSHeaderFile.h"
#import "UIImageView+WebCache.h"
#import "NSPointBaseInfoCell.h"
#import "NSPointAuthorInfoCell.h"
#define KWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

NSString *ID = @"cell";
NSString *NSPointBaseInfoCelllID = @"NSPointBaseInfoCell";
NSString *NSPointAuthorInfoCellID = @"NSPointAuthorInfoCell";
@interface NSPointInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tabelView;
@property (nonatomic, strong)UILabel *showPageLabel;
@property (nonatomic, assign)NSInteger sectionCount;
@property (nonatomic, strong)NSMutableArray *baseInfoArray;
@property (nonatomic, strong)UIView *coverView;
@end

@implementation NSPointInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getNetDatas];
    
}
- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.baseInfoArray = [NSMutableArray new];
    self.dataArray = [NSMutableArray new];
    self.tabelView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tabelView.dataSource = self;
    self.tabelView.delegate = self;
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabelView];
    [self.tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    [self.tabelView registerNib:[UINib nibWithNibName:NSPointBaseInfoCelllID bundle:nil] forCellReuseIdentifier:NSPointBaseInfoCelllID];
    [self.tabelView registerNib:[UINib nibWithNibName:NSPointAuthorInfoCellID bundle:nil] forCellReuseIdentifier:NSPointAuthorInfoCellID];
    
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
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(KWidth/2.0-25, KHeight/2.0-25, 50, 50)];
    
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


- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)getNetDatas{
    [NSHTTPTool SpecialPointInfoGetNetDatas:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        NSPointInfoModel *pointInfoModel = [self.dataArray firstObject];
        //基本信息
        NSMutableArray *phoneArr = [NSMutableArray arrayWithObjects:@"电话",pointInfoModel.phone,nil];
        [self.baseInfoArray addObject:phoneArr];
        if (pointInfoModel.url.length!=0) {
            NSMutableArray *urlArr = [NSMutableArray arrayWithObjects:@"官网",pointInfoModel.url,nil];
            [self.baseInfoArray addObject:urlArr];
        }
        NSMutableArray *addressArr = [NSMutableArray arrayWithObjects:@"地址",pointInfoModel.address,nil];
        [self.baseInfoArray addObject:addressArr];
        if (pointInfoModel.per_cost.length!=0) {
            NSMutableArray *per_costArr = [NSMutableArray arrayWithObjects:@"人均消费",pointInfoModel.per_cost,nil];
            [self.baseInfoArray addObject:per_costArr];
        }
      
        NSMutableArray *best_seasonArr = [NSMutableArray arrayWithObjects:@"旅游季节",pointInfoModel.best_season,nil];
        [self.baseInfoArray addObject:best_seasonArr];
        if (pointInfoModel.suggest_time.length!=0) {
            NSMutableArray *suggest_timeArr = [NSMutableArray arrayWithObjects:@"游玩时长",pointInfoModel.suggest_time,nil];
            [self.baseInfoArray addObject:suggest_timeArr];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tabelView.tableHeaderView = [self tabelViewHeaderView:pointInfoModel];
            self.coverView.hidden = YES;
            [self.tabelView reloadData];
        });
    } point_id:self.point_id error:^(NSError *error) {
        self.coverView.hidden = NO;
        NSLog(@"SpecialPointInfoGetNetDatas----->>%@",error);
    }];
}
#pragma mark - tabelViewHeaderView
- (UIView *)tabelViewHeaderView:(NSPointInfoModel *)model
{
    UIView *tabelViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 0.5*KHeight)];
    tabelViewHeaderView.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 0.35*KHeight)];
        for (int i = 0; i < model.img.count; i++) {
        UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*KWidth, 0, KWidth, scrollView.frame.size.height)];
        [bannerImageView sd_setImageWithURL:[NSURL URLWithString:model.img[i]] placeholderImage:nil];
        [scrollView addSubview:bannerImageView];
    }
    scrollView.contentSize = CGSizeMake(model.img.count * KWidth, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
     self.automaticallyAdjustsScrollViewInsets = NO;
    scrollView.delegate = self;
    [tabelViewHeaderView addSubview:scrollView];
    //showPage
    UIImageView *showPageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth-80, 0.35*KHeight - 30, 70, 25)];
    showPageImageView.image = [UIImage imageNamed:@"photoNum"];
    self.showPageLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 3, 40, 20)];
    self.showPageLabel.text = [NSString stringWithFormat:@"1/%ld",(unsigned long)model.img.count];
    self.showPageLabel.font = [UIFont systemFontOfSize:15];
    self.showPageLabel.textAlignment = NSTextAlignmentCenter;
    self.showPageLabel.textColor = [UIColor whiteColor];
    [showPageImageView addSubview:self.showPageLabel];
    [tabelViewHeaderView addSubview:showPageImageView];
    //titleLabel
    if (model.name_cn.length!=0) {
        UILabel *name_cn_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0.35*KHeight+10, 300, 21)];
        name_cn_label.text = model.name_cn;
        name_cn_label.textColor = [UIColor blackColor];
        name_cn_label.backgroundColor = [UIColor whiteColor];
        [tabelViewHeaderView addSubview:name_cn_label];
    }
    if (model.name_en.length!=0) {
        UILabel *name_en_label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0.35*KHeight+41, 300, 21)];
        name_en_label.textColor = [UIColor lightGrayColor];
        name_en_label.backgroundColor = [UIColor whiteColor];
        name_en_label.text = model.name_en;
        name_en_label.font = [UIFont systemFontOfSize:15];
        [tabelViewHeaderView addSubview:name_en_label];
    }
    return tabelViewHeaderView;
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray&&self.dataArray.count!=0) {
        NSPointInfoModel *pointInfoModel = [self.dataArray firstObject];
        if (pointInfoModel.tips.length!=0) {
            self.sectionCount = 5;
            return 5;
        }else{
            self.sectionCount = 4;
            return 4;
        }
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray&&self.dataArray.count!=0)
    {
        NSPointInfoModel *pointInfoModel = [self.dataArray firstObject];
        if (section == 1) {
            NSInteger count = 0;
            if (pointInfoModel.per_cost.length!=0) {
                count++;
            }
            if (pointInfoModel.url.length!=0) {
                count++;
            }
            if (pointInfoModel.suggest_time.length!=0) {
                count++;
            }
            return 4+count;
        }else{
            return 2;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSPointInfoModel *pointInfoModel = [self.dataArray firstObject];
    if (self.dataArray&&self.dataArray.count!=0)
    {
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"简介";
                    return cell;
                }else{
                    cell.textLabel.text = pointInfoModel.point_content;
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.font = [UIFont systemFontOfSize:15];
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    return cell;
                }
            }
            if (indexPath.section == 1) {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"基本信息";
                    return cell;
                }else{
                    NSPointBaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSPointBaseInfoCelllID];
                    [cell fullCellWith:self.baseInfoArray[indexPath.row-1]];
                    return cell;
                }
            }
            if (indexPath.section == 2) {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"到达方式";
                    return cell;
                }else{
                    cell.textLabel.text = pointInfoModel.point_way;
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.font = [UIFont systemFontOfSize:15];
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    return cell;
                }
            }
        if (self.sectionCount == 4) {
            if (indexPath.section == 3) {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"资料贡献者";
                    return cell;
                }else{
                    NSPointAuthorInfoModel *pointAuthorInfoModel = [self.dataArray lastObject];
                    NSPointAuthorInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSPointAuthorInfoCellID];
                    [cell fullCellWithNSPointAuthorInfoModel:pointAuthorInfoModel];
                    return cell;
                }
            }
        }else if (self.sectionCount == 5){
            if (indexPath.section == 3) {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"小贴士";
                    return cell;
                }else{
                    cell.textLabel.text = pointInfoModel.tips;
                    cell.textLabel.numberOfLines = 0;
                    cell.textLabel.font = [UIFont systemFontOfSize:15];
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    return cell;
                }
            }
            if (indexPath.section == 4) {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"资料贡献者";
                    return cell;
                }else{
                    NSPointAuthorInfoModel *pointAuthorInfoModel = [self.dataArray lastObject];
                    NSPointAuthorInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSPointAuthorInfoCellID];
                    [cell fullCellWithNSPointAuthorInfoModel:pointAuthorInfoModel];
                    return cell;
                }
            }
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tabelView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSPointInfoModel *pointInfoModel = [self.dataArray firstObject];
    NSInteger page = scrollView.contentOffset.x/KWidth;
    self.showPageLabel.text = [NSString stringWithFormat:@"%ld/%ld",page+1,(unsigned long)pointInfoModel.img.count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0|indexPath.section==1) {
        return 44;
    }else{
        return 100;
    }
}
@end
