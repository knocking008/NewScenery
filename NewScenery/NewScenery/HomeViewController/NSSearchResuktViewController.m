//
//  NSSearchResuktViewController.m
//  NewScenery
//
//  Created by mac on 16/1/13.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSSearchResuktViewController.h"
#import "NSResultTableViewCell.h"
#import "NSHTTPTool.h"
#import "NSHeaderFile.h"
#import "NSSearchDesignerCell.h"
#import "NSDesignersInfoViewController.h"
#import "NSPointInfoViewController.h"
#import "NSRouteInfoViewController.h"
static NSString *ID = @"NSResultTableViewCell";
static NSString *NSSearchDesignerCellID = @"NSSearchDesignerCell";

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
@interface NSSearchResuktViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *resultArray;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIImageView *chooseImageView;
@property (nonatomic, strong)UILabel *chooseLabel;
@property (nonatomic, assign)int searchType;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIActivityIndicatorView *juhua;
@property (nonatomic, strong)UILabel *NotFountLabel;


@end

@implementation NSSearchResuktViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI
{
    self.resultArray = [NSMutableArray new];
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, KWidth, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height)];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 120;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forCellReuseIdentifier:ID];
    [self.tableView registerNib:[UINib nibWithNibName:NSSearchDesignerCellID bundle:nil] forCellReuseIdentifier:NSSearchDesignerCellID];
    [self initSearchView];
    //菊花
    self.juhua = [[UIActivityIndicatorView alloc] init];
    self.juhua.center = self.view.center;
    self.juhua.backgroundColor = [UIColor lightGrayColor];
    [self.juhua startAnimating];
    self.juhua.hidden = YES;
    [self.view addSubview:self.juhua];
    //无搜索结果
    self.NotFountLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth/2-85, KHeight/2 - 11, 170, 21)];
    self.NotFountLabel.text = @"抱歉，没有找到相关内容";
    self.NotFountLabel.textColor = [UIColor lightGrayColor];
    self.NotFountLabel.font = [UIFont systemFontOfSize:15];
    self.NotFountLabel.hidden = YES;
    [self.view addSubview:self.NotFountLabel];

    
    //改变状态栏颜色
//    UIView *staBarBag = [[UIView alloc] initWithFrame:CGRectMake(0, -20, KWidth, 20)];
//    staBarBag.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:staBarBag];
}
//初始化自定义搜索框
- (void)initSearchView
{
    self.searchType = 1;
    UIView *searchBagView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, KWidth, self.navigationController.navigationBar.frame.size.height)];
    searchBagView.backgroundColor = [UIColor whiteColor];
    //cancelLabel
    [self.view addSubview:searchBagView];
    UILabel *cancelLabel = [[UILabel alloc] initWithFrame:CGRectMake(KWidth-40, 11, 40, 21)];
    cancelLabel.text = @"取消";
    cancelLabel.textColor = [UIColor cyanColor];
    cancelLabel.font = [UIFont systemFontOfSize:15];
    UITapGestureRecognizer *cancelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)];
    cancelLabel.userInteractionEnabled = YES;
    [cancelLabel addGestureRecognizer:cancelTap];
    [searchBagView addSubview:cancelLabel];
    //textField
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 6, KWidth-80, 30)];
    self.textField.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1];
    self.textField.layer.cornerRadius = 12;
    self.textField.layer.masksToBounds = YES;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.delegate = self;
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.returnKeyType = UIReturnKeySearch;
    [searchBagView addSubview:self.textField];
    [self textFieldFrameWithPadding:60];
     [self.textField becomeFirstResponder];
    //选择搜索类型
   self.chooseLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 31, 60, 21)];
    self.chooseLabel.text = @"路线 ▾";
    self.chooseLabel.textColor = [UIColor lightGrayColor];
    self.chooseLabel.font = [UIFont systemFontOfSize:15];
    self.chooseLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *chooseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTapAction)];
    [self.chooseLabel addGestureRecognizer:chooseTap];
    [self.view addSubview:self.chooseLabel];
    //选择
    self.chooseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 58, 80, 90)];
    self.chooseImageView.image = [UIImage imageNamed:@"searchPop"];
    self.chooseImageView.backgroundColor = [UIColor clearColor];
    self.chooseImageView.userInteractionEnabled = YES;
    self.chooseImageView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view addSubview:self.chooseImageView];
    }];
    
    NSArray *typeName = @[@"路线",@"设计师",@"景点"];
    for (int i = 0; i < 3; i++) {
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, i*20+10, 70, 30)];
        typeLabel.text = [NSString stringWithFormat:@"%@",typeName[i]];
        typeLabel.font = [UIFont systemFontOfSize:14];
        typeLabel.userInteractionEnabled = YES;
        typeLabel.tag = 10+i;
        [self.chooseImageView addSubview:typeLabel];
        if (i>0) {
            UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, i*20+15, 65, 1)];
            lineImageView.image = [UIImage imageNamed:@"line"];
            [self.chooseImageView addSubview:lineImageView];
        }
        UITapGestureRecognizer *tapType = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTypeAction:)];
        [typeLabel addGestureRecognizer:tapType];
    }
  
}
//设置textfield的光标位置
-(void)textFieldFrameWithPadding:(CGFloat)padding
{
    CGRect frame = self.textField.frame;
    frame.size.width = padding;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = leftview;
}

- (void)tapTypeAction:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.chooseImageView.hidden = YES;
    }];
    
    if (sender.view.tag == 10) {
        self.chooseLabel.text = @"路线 ▾";
        [self textFieldFrameWithPadding:60];
        self.searchType = 1;
    }else if (sender.view.tag == 11){
        self.chooseLabel.text = @"设计师 ▾";
        [self textFieldFrameWithPadding:70];
        self.searchType = 2;
    }else if (sender.view.tag == 12){
        self.chooseLabel.text = @"景点 ▾";
        [self textFieldFrameWithPadding:60];
        self.searchType = 3;
    }
}
- (void)chooseTapAction
{
    [UIView animateWithDuration:0.5 animations:^{
        self.chooseImageView.hidden = !self.chooseImageView.hidden;
    }];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1];
    if (self.searchType == 1) {
        NSSearchRouteModel *searchRouteModel = self.resultArray[indexPath.row];
        [cell fullCellWithNSSearchRouteModel:searchRouteModel];
        return cell;
    }else if (self.searchType == 2){
        NSSearchDesignerModel *searchDesignerModel = self.resultArray[indexPath.row];
        NSSearchDesignerCell *searchDesignerCell = [tableView dequeueReusableCellWithIdentifier:NSSearchDesignerCellID];
        [searchDesignerCell fullCellWithNSSearchDesignerModel:searchDesignerModel];
        searchDesignerCell.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1];
        return searchDesignerCell;
    }else if (self.searchType == 3){
        NSSearchPointModel *searchPointModel = self.resultArray[indexPath.row];
        [cell fullCellWithNSSearchPointModel:searchPointModel];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.searchType == 1) {
        NSSearchRouteModel *model = self.resultArray[indexPath.row];
        NSRouteInfoViewController *routeInfoViewController = [[NSRouteInfoViewController alloc] init];
        routeInfoViewController.routeID = model.route_id;
        [self.navigationController pushViewController:routeInfoViewController animated:YES];
    }else if (self.searchType == 2){
        NSSearchDesignerModel *searchDesignerModel = self.resultArray[indexPath.row];
        NSDesignersInfoViewController *designersInfoViewController = [[NSDesignersInfoViewController alloc] init];
        designersInfoViewController.desinerID = searchDesignerModel.uid;
        [self.navigationController pushViewController:designersInfoViewController animated:YES];
    }else if (self.searchType == 3){
        NSSearchPointModel *searchPointModel = self.resultArray[indexPath.row];
        NSPointInfoViewController *pointInfoViewController = [[NSPointInfoViewController alloc] init];
        pointInfoViewController.point_id = searchPointModel.point_id;
        [self.navigationController pushViewController:pointInfoViewController animated:YES];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.NotFountLabel.hidden = YES;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.juhua.hidden = NO;
    self.NotFountLabel.hidden = YES;
    [NSHTTPTool SearchRouteListGetNetDataWithType:self.searchType KeyWord:self.textField.text page:1 data:^(NSArray *data) {
        [self.resultArray removeAllObjects];
       
        [self.resultArray addObjectsFromArray:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(data.count == 0){
                self.NotFountLabel.hidden = NO;
            }
            self.juhua.hidden = YES;
            [self.tableView reloadData];
        });
    } error:^(NSError *error) {
        NSLog(@"SearchRouteListGetNetDataWithType---------->>%@",error);
    }];
    [self.view endEditing:YES];
    return YES;
}
@end
