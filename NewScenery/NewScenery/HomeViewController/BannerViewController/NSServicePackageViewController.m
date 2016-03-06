//
//  NSServicePackageViewController.m
//  NewScenery
//
//  Created by mac on 16/1/28.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSServicePackageViewController.h"
#import "NSHeaderFile.h"
#import "NSHTTPTool.h"
#import "UWDatePickerView.h"

#import "NSTargetCell.h"
#import "NSDateCell.h"
#import "NSMenuCell.h"
#import "NSNumberOfPeopleCell.h"
#import "NSUserInfoCell.h"
#import "NSPriceCell.h"
#import "NSDefaultCell.h"

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

static NSString *NSTargetCellID = @"NSTargetCell";
static NSString *NSDateCellID = @"NSDateCell";
static NSString *NSMenuCellID = @"NSMenuCell";
static NSString *NSNumberOfPeopleCellID = @"NSNumberOfPeopleCell";
static NSString *NSUserInfoCellID = @"NSUserInfoCell";
static NSString *NSPriceCellID = @"NSPriceCell";
static NSString *NSDefaultCellID = @"NSDefaultCell";


@interface NSServicePackageViewController ()<UITableViewDataSource,UITableViewDelegate,UWDatePickerViewDelegate>

@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, assign) int  package;
@property (nonatomic, assign) int  number;
@property (nonatomic, strong) UWDatePickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, assign) BOOL isBeginDate;
@property (nonatomic, assign) NSTimeInterval overTime;
@property (nonatomic, assign) NSTimeInterval beginTime;
@property (nonatomic, strong) NSMutableArray *intervalTime;
@property (nonatomic, assign) int  price;
@property (nonatomic, assign) int  numberOfPeople;
@property (nonatomic, strong) NSMutableArray *userInfoArray;
@property (nonatomic, assign) BOOL isTouchField;

@end

@implementation NSServicePackageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getNetDatas];
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"你的定制要求？";
    self.dataArray = [NSMutableArray new];
    self.dateArray = [NSMutableArray new];
    self.intervalTime  = [NSMutableArray arrayWithObjects:@"0", @"0",@"0",nil];
    self.userInfoArray = [NSMutableArray arrayWithObjects:@"",@"",nil];

    self.number = 8;
    self.numberOfPeople = 1;

    self.self.titleArray = @[@"旅行目的",@"旅行日期",@"定制套餐",@"旅行人数",@"联系人",@"价格"];
    self.tabelView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tabelView.dataSource = self;
    self.tabelView.delegate = self;
    self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tabelView];
    
    [self.tabelView registerNib:[UINib nibWithNibName:NSTargetCellID bundle:nil] forCellReuseIdentifier:NSTargetCellID];
    [self.tabelView registerNib:[UINib nibWithNibName:NSDateCellID bundle:nil] forCellReuseIdentifier:NSDateCellID];
    [self.tabelView registerNib:[UINib nibWithNibName:NSMenuCellID bundle:nil] forCellReuseIdentifier:NSMenuCellID];
    [self.tabelView registerClass:[NSNumberOfPeopleCell class] forCellReuseIdentifier:NSNumberOfPeopleCellID];
    [self.tabelView registerClass:[NSUserInfoCell class] forCellReuseIdentifier:NSUserInfoCellID];
    [self.tabelView registerClass:[NSPriceCell class] forCellReuseIdentifier:NSPriceCellID];
    [self.tabelView registerNib:[UINib nibWithNibName:NSDefaultCellID bundle:nil] forCellReuseIdentifier:NSDefaultCellID];
    
    UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KHeight-30, KWidth, 30)];
    orderLabel.tag = 100;
    orderLabel.text = @"提交订单";
    orderLabel.textColor = [UIColor whiteColor];
    orderLabel.backgroundColor = [UIColor cyanColor];
    orderLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *orderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderTapAction)];
    orderLabel.userInteractionEnabled = YES;
    [orderLabel addGestureRecognizer:orderTap];
    [self.view addSubview:orderLabel];
    
    //通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(packageAction:) name:@"package" object:nil];
    [center addObserver:self selector:@selector(packageDateAction:) name:@"packageDate" object:nil];
    [center addObserver:self selector:@selector(NumberOfPeople:) name:@"numberOfPeople" object:nil];
    [center addObserver:self selector:@selector(userInfoError:) name:@"userInfoError" object:nil];
    [center addObserver:self selector:@selector(userInfo:) name:@"userInfo" object:nil];
    //键盘位置
    [center addObserver:self selector:@selector(fieldWasTouch) name:@"touchField" object:nil];
    [center addObserver:self selector:@selector(keyboardShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardHideAction:) name:UIKeyboardWillHideNotification object:nil];
    
}
//提交订单
- (void)orderTapAction{
    if ([self.userInfoArray[0] isEqualToString:@""]) {
        [self alerText:@"联系人不能为空"];
        return;
    }
    if ([self.userInfoArray[1] isEqualToString:@""]) {
        [self alerText:@"请输入正确的手机号码"];
        return;
    }
    if ([self.intervalTime[0] isEqualToString:@"0"]) {
        [self alerText:@"请选择旅行开始时间"];
        return;
    }
    if ([self.intervalTime[1] isEqualToString:@"0"]) {
        [self alerText:@"请选择旅行结束日期"];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fieldWasTouch{
    self.isTouchField = YES;
}

- (void)keyboardShowAction:(NSNotification *)notifi{
    UILabel *label = (UILabel *)[self.view viewWithTag:100];
    
    if (self.isTouchField) {//判断是否为第一响应者
        //得到textField的最大边
        CGFloat maxY = CGRectGetMaxY(label.frame);
        //  得到键盘最小边
        NSDictionary *userInfo = notifi.userInfo;
        NSValue *value = userInfo[@"UIKeyboardFrameEndUserInfoKey"];
        CGRect keyboardFrame = [value CGRectValue];//得到键盘的frame
//        NSLog(@"keyboardFrame--->>%@---userInfoCell.frame---%@",NSStringFromCGRect(keyboardFrame),NSStringFromCGRect(userInfoCell.frame));
        CGFloat minY = CGRectGetMinY(keyboardFrame);
        if ((maxY - minY) > 0) {
            //      改变self.view的Y坐标
            //      将self.view往上移动
            [UIView animateWithDuration:0.25 animations:^{
                
                CGRect frame = self.view.frame;
                frame.origin.y = minY - maxY;
                self.view.frame = frame;
                
            } completion:nil];
        }
    }
}
- (void)keyboardHideAction:(NSNotification *)notifi{
    //    恢复view的位置
    self.view.frame = self.view.bounds;
    self.isTouchField = NO;
}

//用户输入错误提醒
- (void)userInfoError:(NSNotification *)notifi{
    if ([notifi.object isEqualToString:@"phone"]) {
         [self alerText:@"请输入正确的电话号码"];
    }else{
        [self alerText:@"联系人不能为空"];
    }
}
//用户信息
- (void)userInfo:(NSNotification *)notifi{
    if ([notifi.object isEqualToString:@"phone"]) {
        [self.userInfoArray replaceObjectAtIndex:1 withObject:notifi.userInfo[@"phone"]];
    }else{
        [self.userInfoArray replaceObjectAtIndex:0 withObject:notifi.userInfo[@"name"]];
    }
}

//选择人数
- (void)NumberOfPeople:(NSNotification *)notifi{
    self.numberOfPeople = [notifi.object intValue];
    [self totalPrice];
    [self.tabelView reloadData];
}

//选择套餐
- (void)packageAction:(NSNotification *)notifi{
    self.number = 8;
   
    if ([notifi.object isEqualToString:@"freeTapAction"]) {
        self.package = 0;
        self.numberOfPeople = 1;
    }else if ([notifi.object isEqualToString:@"standarTapAction"]){
        self.package = 1;
    }else if ([notifi.object isEqualToString:@"plusTapAction"]){
        self.package = 2;
    }else if ([notifi.object isEqualToString:@"vipTapAction"]){
        self.number = 99;
        self.numberOfPeople = 9;
        self.package = 3;
    }
    [self totalPrice];
    [self.tabelView reloadData];
}
//选择时间
- (void)packageDateAction:(NSNotification *)notifi{
    if ([notifi.object isEqualToString:@"beginTap"]) {
        self.isBeginDate = YES;
        [self setupDateView:DateTypeOfStart];
    }else if ([notifi.object isEqualToString:@"overTap"]){
        self.isBeginDate = NO;
        [self setupDateView:DateTypeOfStart];
    }
}
//收起键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)getNetDatas{
    [NSHTTPTool ServicePackageGetNetDatas:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabelView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"ServicePackageGetNetDatas--->>%@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray.count == 0) {
        return 0;
    }
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.resultArray.count!=0) {
        return self.resultArray.count+1;
    }
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSDefaultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSDefaultCellID];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell fullDefaultCellWithTitle:self.self.titleArray[indexPath.section]];
            return cell;
        }
        
        NSTargetCell *targetCell = [tableView dequeueReusableCellWithIdentifier:NSTargetCellID];
        [targetCell fullCellWithNSPlaceModel:self.resultArray[indexPath.row-1]];
        return targetCell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [cell fullDefaultCellWithTitle:self.self.titleArray[indexPath.section]];
            return cell;
        }
        NSDateCell *dateCell = [tableView dequeueReusableCellWithIdentifier:NSDateCellID];
        [dateCell fullDateCellIntervalTime:self.intervalTime];
        return dateCell;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            [cell fullDefaultCellWithTitle:self.self.titleArray[indexPath.section]];
            return cell;
        }
        NSMenuCell *menuCell = [tableView dequeueReusableCellWithIdentifier:NSMenuCellID];
        [menuCell fullMenuCellWithNSServicePackageModel:self.dataArray[self.package]];
        return menuCell;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            [cell fullDefaultCellWithTitle:self.self.titleArray[indexPath.section]];
            return cell;
        }
        NSNumberOfPeopleCell *numberOfPeopleCell = [tableView dequeueReusableCellWithIdentifier:NSNumberOfPeopleCellID];
        [numberOfPeopleCell fullNumberOfPeopleCell:self.number];
        return numberOfPeopleCell;
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            [cell fullDefaultCellWithTitle:self.self.titleArray[indexPath.section]];
            return cell;
        }
        NSUserInfoCell *userInfoCell = [tableView dequeueReusableCellWithIdentifier:NSUserInfoCellID];
       
        return userInfoCell;
    }else if (indexPath.section == 5){
        if (indexPath.row == 0) {
            [cell fullDefaultCellWithTitle:self.self.titleArray[indexPath.section]];
            return cell;
        }
        NSPriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:NSPriceCellID];
        [priceCell fullPriceCellWithCount:self.price];
        return priceCell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 60;
    }
    if (indexPath.section == 1) {
        return 44;
    }
    if (indexPath.section == 2) {
        return 190;
    }
    if (indexPath.section == 3) {
        return 50;
    }
    if (indexPath.section == 5) {
        return 44;
    }
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
}

#pragma mark - UWDatePickerViewDelegate
- (void)setupDateView:(DateType)type {
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_pickerView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.1]];
    _pickerView.delegate = self;
    _pickerView.type = type;
    [self.view addSubview:_pickerView];
    
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    NSDate *tourDate = [dateFormatter dateFromString:date];
    if (self.isBeginDate) {
        if ([tourDate timeIntervalSinceNow] > 0) {
            [self.tabelView reloadData];
            [self.intervalTime replaceObjectAtIndex:0 withObject:date];
            if ([tourDate timeIntervalSinceNow] > (int)([tourDate timeIntervalSinceNow]/(60*60*24))) {
                self.beginTime = (int)([tourDate timeIntervalSinceNow]/(60*60*24))+1;
            }else{
                self.beginTime = (int)([tourDate timeIntervalSinceNow]/(60*60*24));
            }
        }else{
            [self alerText:@"请选择大于今天的时间"];
        }
    }else{
        if ([tourDate timeIntervalSinceNow] > 0 && [tourDate timeIntervalSinceNow] > self.beginTime) {
            if ([tourDate timeIntervalSinceNow] > (int)([tourDate timeIntervalSinceNow]/(60*60*24))) {
                self.overTime = (int)([tourDate timeIntervalSinceNow]/(60*60*24))+1;
            }else{
                self.overTime = (int)([tourDate timeIntervalSinceNow]/(60*60*24));
            }
            [self.intervalTime replaceObjectAtIndex:1 withObject:date];
        }else{
            [self alerText:@"请选择大于旅行开始日期"];
        }
    }
    if (self.overTime>0 && self.beginTime>0) {
        if (self.overTime > self.beginTime &&self.beginTime!=0) {
            [self.intervalTime replaceObjectAtIndex:2 withObject:@(self.overTime - self.beginTime+1)];
            [self totalPrice];
            [self.tabelView reloadData];
        }else{
            [self alerText:@"请选择大于旅行开始日期"];
        }
    }

}

- (void)totalPrice{
    if ((self.overTime - self.beginTime) > 0) {
        NSServicePackageModel *servicePackageModel = self.dataArray[self.package];
        if (self.package == 3) {
            self.price = [servicePackageModel.price intValue]*(self.overTime - self.beginTime)*self.numberOfPeople;
        }else{
            self.price = [servicePackageModel.price intValue]*(self.overTime - self.beginTime);
        }
    }
}

- (void)alerText:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

@end
