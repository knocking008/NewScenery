//
//  NSDesignersInfoViewController.m
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSDesignersInfoViewController.h"
#import "NSHTTPTool.h"
#import "NSPhoneServiceViewController.h"
#import "NSDoorToDoorViewController.h"
#import "NSBeginCustomizedViewController.h"
#import "NSTableHeaderView.h"

#import "NSCanCell.h"
#import "NSDesignerInfoCell.h"
#import "NSSkilledCell.h"
#import "NSWorkCell.h"
#import "NSSatisfiedCell.h"
#import "NSappraiseCell.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

static NSString *NormalCellID = @"cell";
static NSString *CanCellID = @"NSCanCell";
static NSString *DesignerInfoCellID = @"NSDesignerInfoCell";
static NSString *SkilledCellID = @"NSSkilledCell";
static NSString *WorkCellID = @"NSWorkCell";
static NSString *SatisfiedCellID = @"NSSatisfiedCell";
static NSString *appraiseCellID = @"NSappraiseCell";

@interface NSDesignersInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSTableHeaderView *tableHeaderView;
@property (nonatomic, strong)UIView *coverView;
@end

@implementation NSDesignersInfoViewController

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

    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NormalCellID];
    
    [self.tableView registerNib:[UINib nibWithNibName:CanCellID bundle:nil] forCellReuseIdentifier:CanCellID];
    [self.tableView registerNib:[UINib nibWithNibName:DesignerInfoCellID bundle:nil] forCellReuseIdentifier:DesignerInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:SkilledCellID bundle:nil] forCellReuseIdentifier:SkilledCellID];
    [self.tableView registerNib:[UINib nibWithNibName:WorkCellID bundle:nil] forCellReuseIdentifier:WorkCellID];
    [self.tableView registerNib:[UINib nibWithNibName:SatisfiedCellID bundle:nil] forCellReuseIdentifier:SatisfiedCellID];
    [self.tableView registerNib:[UINib nibWithNibName:appraiseCellID bundle:nil] forCellReuseIdentifier:appraiseCellID];
    
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
    [NSHTTPTool MoreInfoForDesinerGetNetDatas:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        dispatch_async(dispatch_get_main_queue(), ^{
           
            self.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"NSTableHeaderView" owner:nil options:nil].firstObject;
            self.tableHeaderView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 320);
            self.tableView.tableHeaderView = self.tableHeaderView;
            [self.tableHeaderView fullCellWithDesignerBaseInfoModel:self.dataArray[0]];
             self.coverView.hidden = YES;
            [self.tableView reloadData];
            
        });
    } desinerID:self.desinerID error:^(NSError *error) {
        NSLog(@"MoreInfoForDesinerGetNetDatas----->%@",error);
    }];
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray&&self.dataArray.count!=0) {
        if (section == 0) {
            NSDesignerBaseInfoModel *model = self.dataArray[0];
            NSInteger count = 0;
            if ([model.can_phone_service integerValue] == 1) {
                count++;
            }
            if ([model.can_doortodoor integerValue]==1) {
                count++;
            }
            if ([model.can_route_service integerValue]==1) {
                count++;
            }
            return count;
        }else if (section == 3){
            NSArray *tmpArr = self.dataArray[1];
            return tmpArr.count+1;
        }else if (section == 5){
            NSArray *tmpArr = self.dataArray[2];
            return tmpArr.count+1;
        }else{
            return 2;
        }
    }else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSCanCell *cell = [tableView dequeueReusableCellWithIdentifier:CanCellID];
        NSDesignerBaseInfoModel *model = self.dataArray[0];
        if (model.can_phone_service&&indexPath.row==0) {
            [cell fullCellWith:@"can_phone_service"];
            return cell;
        }
        if (model.can_doortodoor&&indexPath.row==1) {
            [cell fullCellWith:@"can_doortodoor"];
            return cell;
        }
        if (model.can_route_service&&indexPath.row==2) {
            [cell fullCellWith:@"can_route_service"];
            return cell;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row==0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalCellID];
            cell.textLabel.text = @"设计师介绍";
            return cell;
        }
        NSDesignerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:DesignerInfoCellID];
        NSDesignerBaseInfoModel *model = self.dataArray[0];
        [cell fullCell:model.desc];
        return cell;
    }
    if (indexPath.section == 2) {
        if (indexPath.row==0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalCellID];
            cell.textLabel.text = @"擅长";
            return cell;
        }
        NSSkilledCell *cell = [tableView dequeueReusableCellWithIdentifier:SkilledCellID];
        NSDesignerBaseInfoModel *model = self.dataArray[0];
        [cell fullCellWithSkill:model.skill];
        return cell;
    }
    if (indexPath.section == 3) {
        if (indexPath.row==0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalCellID];
            cell.textLabel.text = @"部分路线作品";
            return cell;
        }
        NSWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:WorkCellID];
        NSArray *tmpArr = self.dataArray[1];
        NSDesignerWorksModel *model = tmpArr[indexPath.row-1];
        [cell fullCellWithDesignerWorksModel:model];
        return cell;
    }
    if (indexPath.section == 4) {
        if (indexPath.row==0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalCellID];
            cell.textLabel.text = @"整体满意度";
            return cell;
        }
        NSSatisfiedCell *cell = [tableView dequeueReusableCellWithIdentifier:SatisfiedCellID];
        NSDesignerBaseInfoModel *model = self.dataArray[0];
        NSMutableArray *tmpArr = [NSMutableArray new];
        [tmpArr addObject:model.route_av];
        [tmpArr addObject:model.service_av];
        [tmpArr addObject:model.efficiency_av];
        [cell fullCellWithSatisfied:tmpArr];
        return cell;
    }
    if (indexPath.section == 5) {
        if (indexPath.row==0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NormalCellID];
            cell.textLabel.text = @"评论";
            return cell;
        }
        NSArray *tmpArr = self.dataArray[2];
        NSAppraise_listForDesignerModel *model = tmpArr[indexPath.row-1];
        NSappraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:appraiseCellID];
        [cell fullCellWithAppraise_listForDesignerModel:model];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test--->%ld --- %ld",(long)indexPath.section,(long)indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 21)];
    headerView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 21;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDesignerBaseInfoModel *model = self.dataArray[0];
    if(indexPath.section==1){
        if (indexPath.row == 0) {
            return 44;
        }
        
        return [NSDesignerInfoCell getCellHeightWith:model.desc];
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 44;
        }
        NSArray *tmpArr = [model.skill componentsSeparatedByString:@"·"];
        
        return [NSDesignerBaseInfoModel HeighForCollectionView:tmpArr];
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            return 44;
        }
        return 90;
    }
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            return 44;
        }
        return 100;
    }
    if (indexPath.section == 5) {
        if (indexPath.row == 0) {
            return 44;
        }
        NSArray *tmpArr = self.dataArray[2];
        NSAppraise_listForDesignerModel *model = tmpArr[indexPath.row-1];
        return [NSappraiseCell getCellHeightWith:model.content];
    }
    return 40;
}

//跳到相应页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDesignerBaseInfoModel *DesignerBaseInfoModel = [self.dataArray firstObject];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
           
            NSPhoneServiceViewController *PhoneServiceViewController = [NSPhoneServiceViewController new];
            PhoneServiceViewController.designerID = self.desinerID;
            PhoneServiceViewController.designerType = DesignerBaseInfoModel.designer_type;
            [self.navigationController pushViewController:PhoneServiceViewController animated:YES];
        }else if (indexPath.row == 1){
        
            NSDoorToDoorViewController *DoorToDoorViewController = [NSDoorToDoorViewController new];
            DoorToDoorViewController.designerID = self.desinerID;
            DoorToDoorViewController.designerType = DesignerBaseInfoModel.designer_type;
            [self.navigationController pushViewController:DoorToDoorViewController animated:YES];
        }else if (indexPath.row == 2){
            NSBeginCustomizedViewController *BeginCustomizedViewController = [NSBeginCustomizedViewController new];
            [self.navigationController pushViewController:BeginCustomizedViewController animated:YES];
        }
    }
}
@end
