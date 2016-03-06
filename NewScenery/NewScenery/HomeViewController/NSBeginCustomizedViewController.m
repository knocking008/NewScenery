//
//  NSBeginCustomizedViewController.m
//  NewScenery
//
//  Created by mac on 16/1/14.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSBeginCustomizedViewController.h"
#import "NSHTTPTool.h"
#import "NSBeginCustomizedCell.h"
#import "NSHeaderFile.h"
#import "NSBeginCustomizedSubViewController.h"
#import "NSServicePackageViewController.h"

#define Kwidth [UIScreen mainScreen].bounds.size.width
#define kheight [UIScreen mainScreen].bounds.size.height
#define kbtnWidth (Kwidth-44)/3
static NSString *NSBeginCustomizedCellID = @"NSBeginCustomizedCell";
@interface NSBeginCustomizedViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong)UIScrollView     *begScrollView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray   *dataArray;

@property (nonatomic, assign)BOOL             isTouchCell;
@property (nonatomic, strong)NSMutableArray   *selectResult;
@property (nonatomic, strong)UIScrollView     *selectScrollView;
@property (nonatomic, strong)UIView           *selectShowView;
@property (nonatomic, strong)UIButton         *selectBtn;
@property (nonatomic, strong)UIScrollView     *scrollView;
@property (nonatomic, strong)UIImageView      *lineImageView;
@property (nonatomic, assign)NSInteger        seclectIndex;
@property (nonatomic, strong)UIView *coverView;
@end

@implementation NSBeginCustomizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self getNetDatas];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationItem.title = @"想去哪里旅行";
    
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)initUI
{
    //=======初始化框架背景view
    self.begScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    self.begScrollView.pagingEnabled = YES;
    self.begScrollView.delegate = self;
    self.begScrollView.contentSize = CGSizeMake(Kwidth*7, kheight-64);
    [self.view addSubview:self.begScrollView];

    //-------------------初始化滚动按钮----
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64, Kwidth, 30)];
    //******//
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.scrollView.contentSize = CGSizeMake(Kwidth+20, 30);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    NSArray *locationName = @[@"热门目的地",@"境内",@"亚洲",@"欧洲",@"大洋洲",@"美洲",@"非洲"];
    CGFloat btnWidth = Kwidth/7.5;
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i==0) {
            btn.frame = CGRectMake(i*btnWidth, 0, btnWidth*2, 30);
        }else{
            btn.frame = CGRectMake(i*btnWidth+btnWidth, 0, btnWidth, 30);
        }
        [btn.layer setBorderWidth:0.3];
        btn.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:locationName[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.tag = i+100;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        if (btn.tag == 0 ) {
            [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
        }
    }
    //按钮下划线
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 94, btnWidth*2, 1)];
    self.lineImageView.image = [UIImage imageNamed:@"regionBotLine"];
    [self.view addSubview:self.lineImageView];
    self.dataArray = [NSMutableArray new];
    //分割线
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kheight-36, Kwidth, 1)];
    lineImageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineImageView];
     //============= 重构展示框架
     for (int i = 0; i<7; i++) {
        NSBeginCustomizedSubViewController *subViewController = [[NSBeginCustomizedSubViewController alloc] init];
        subViewController.view.frame = CGRectMake(i*Kwidth,94,Kwidth, kheight-35);
        [self addChildViewController:subViewController];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.itemSize = CGSizeMake((170/667.0)*kheight, (100/667.0)*kheight);
            layout.minimumInteritemSpacing = 10;
            layout.minimumLineSpacing = 10;
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
            UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, Kwidth, self.view.bounds.size.height-130) collectionViewLayout:layout];
                collectionView.backgroundColor = [UIColor whiteColor];
            collectionView.dataSource = self;
            collectionView.delegate = self;
                collectionView.tag = i+10;
            [subViewController.view addSubview:collectionView];
            [collectionView registerNib:[UINib nibWithNibName:NSBeginCustomizedCellID bundle:nil] forCellWithReuseIdentifier:NSBeginCustomizedCellID];
        [self.begScrollView addSubview:subViewController.view];
    }
    //=============
    
    //展示选择结果
    self.selectResult = [NSMutableArray new];
    
    
    self.selectScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kheight-35, Kwidth-50, 35)];
    self.selectScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.selectScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectScrollView];
    
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.frame = CGRectMake(Kwidth-50, kheight-35, 50, 35);
    [self.selectBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.selectBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.selectBtn.backgroundColor = [UIColor whiteColor];
    [self.selectBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.selectBtn];
    
    self.selectShowView = [[UIView alloc] initWithFrame:CGRectMake(0,kheight - 35, Kwidth, 35)];
    self.selectShowView.backgroundColor = [UIColor whiteColor];
    UILabel *remindLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Kwidth, 35)];
    remindLabel.text = @"请选择路线您想去的地方";
    remindLabel.font = [UIFont systemFontOfSize:13];
    remindLabel.textColor = [UIColor cyanColor];
    remindLabel.textAlignment = NSTextAlignmentCenter;
    [self.selectShowView addSubview:remindLabel];
    [self.view addSubview:self.selectShowView];
    
    //创建蒙版view
    self.coverView = [[UIView alloc] initWithFrame:self.view.frame];
    self.coverView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverView];
    UIActivityIndicatorView *juhua = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(Kwidth/2.0-25, kheight/2.0-25, 50, 50)];
    
    juhua.backgroundColor = [UIColor lightGrayColor];
    [juhua startAnimating];
    [self.coverView addSubview:juhua];
}

- (void)getNetDatas{
    [NSHTTPTool BeginCustomizedGetNetData:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
            UICollectionView *collectionView = (UICollectionView *)[self.begScrollView viewWithTag:10];
        dispatch_async(dispatch_get_main_queue(), ^{
           self.coverView.hidden = YES;
            [collectionView reloadData];
        });
        
    } error:^(NSError *error) {
        NSLog(@"BeginCustomizedGetNetData---------->%@",error);
    }];
}

- (void)selectBtnAction{
    NSServicePackageViewController *servicePackageViewController = [NSServicePackageViewController new];
    servicePackageViewController.resultArray = self.selectResult;
    [self.navigationController pushViewController:servicePackageViewController animated:YES];
}
- (void)btnAction:(UIButton *)sender
{
    self.seclectIndex = sender.tag-100;
    for (id obj in self.scrollView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    [sender setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.lineImageView.frame = CGRectMake(sender.frame.origin.x, 94, sender.frame.size.width, 1);
    [self.begScrollView setContentOffset:CGPointMake(Kwidth*(sender.tag-100), 0) animated:YES];
    UICollectionView *collectionView = (UICollectionView *)[self.view viewWithTag:sender.tag-90];
    [collectionView reloadData];
    
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray&&self.dataArray.count!=0) {
        NSArray *tmpArray = self.dataArray[collectionView.tag-10];
    return tmpArray.count;
    }else{
        return 0;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSBeginCustomizedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSBeginCustomizedCellID forIndexPath:indexPath];
    NSMutableArray *tmpArray = self.dataArray[collectionView.tag-10];
    NSPlaceModel *model = tmpArray[indexPath.row];
    [cell fullCellWithbPlaceModel:model];

    cell.selectBtn.selected = model.isSectel;

       return cell;
}
#pragma mark - LocationSelect
- (void)LocationSelect:(NSMutableArray *)selectResult{
    
    if (selectResult&&selectResult.count!=0) {
        self.selectShowView.hidden = YES;
        self.selectScrollView.contentSize = CGSizeMake(selectResult.count*kbtnWidth, 44);
        NSArray *subView = [self.selectScrollView subviews];
        for (UIView *tmpView in subView) {
            [tmpView removeFromSuperview];
        }
        for (int i = 0; i < selectResult.count; i++) {
            NSPlaceModel *model = selectResult[i];
            UIButton *selectResultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            selectResultBtn.frame = CGRectMake(i*kbtnWidth+10, 5, kbtnWidth-20, 25);
            [selectResultBtn setImage:[UIImage imageNamed:@"selectBox"] forState:UIControlStateNormal];
            [self.selectScrollView addSubview:selectResultBtn];
            if (self.selectResult.count > 3) {
                [self.selectScrollView setContentOffset:CGPointMake((selectResult.count-3)*kbtnWidth, 0) animated:YES];
            }
            UIButton *tapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tapBtn.frame = CGRectMake(51, 0, 50, 44);
            tapBtn.tag = self.selectResult.count+99;
            [tapBtn addTarget:self action:@selector(deSelectAction:) forControlEvents:UIControlEventTouchUpInside];
            [selectResultBtn addSubview:tapBtn];
        
            //已选择的地名
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(12-model.title.length, 3, 50, 20)];
            nameLabel.text = model.title;
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.font = [UIFont systemFontOfSize:12-model.title.length/2];
            nameLabel.textColor = [UIColor cyanColor];
            [selectResultBtn addSubview:nameLabel];
        }
    }else{
        self.selectShowView.hidden = NO;
    }
}
- (void)deSelectAction:(UIButton *)sender{

    //更改数据源中按钮的状态
    NSPlaceModel *model = self.selectResult[sender.tag-100];
    for (NSArray *subArr in self.dataArray) {
        for (NSPlaceModel *tmpModel in subArr) {
            if ([model.title isEqualToString:tmpModel.title]) {
                tmpModel.isSectel = !tmpModel.isSectel;
            }
        }
    }
    //删除self.selectResult中相应的对象
    [self.selectResult removeObjectAtIndex:sender.tag-100];
       //重新加载选择栏视图
    NSArray *locationName = @[@"热门目的地",@"境内",@"亚洲",@"欧洲",@"大洋洲",@"美洲",@"非洲"];
    for (int i = 0; i < locationName.count; i++) {
        if ([locationName[i] isEqualToString:model.locationTypt]) {
            UICollectionView *collectionView = (UICollectionView *)[self.view viewWithTag:i+10];
                [collectionView reloadData];
        }
    } 
    [self LocationSelect:self.selectResult];
    
}
#pragma mark - UICollectionViewDelegateFlowLayout

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //记录旅游地点是否被选择
    NSArray *tmpArr = self.dataArray[collectionView.tag-10];
    NSPlaceModel *model = tmpArr[indexPath.row];
    for (NSArray *subArr in self.dataArray) {
        for (NSPlaceModel *tmpModel in subArr) {
            if ([model.title isEqualToString:tmpModel.title]) {
                tmpModel.isSectel = !tmpModel.isSectel;
            }
        }
    }
    //收集选择结果
    if (model.isSectel)
    {
        if (self.selectResult.count!=0)
        {
            BOOL isExist = NO;
            for (NSPlaceModel *tmpModel in self.selectResult)
            {
                if ([tmpModel.title isEqualToString:model.title])
                {
                    isExist = YES;
                }
            }
            if (isExist) {
                [self.selectResult removeObject:model];
                [self.selectResult addObject:model];
            }
            else
            {
                [self.selectResult addObject:model];
            }
        }
        else
        {
            [self.selectResult addObject:model];
        }
    }
    else
    {
        [self.selectResult removeObject:model];
    }
    [self LocationSelect:self.selectResult];

    [collectionView reloadData];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.seclectIndex = scrollView.contentOffset.x / Kwidth;
    for (id obj in self.scrollView.subviews) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [obj setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    UIButton *btn = (UIButton *)[self.scrollView viewWithTag:self.seclectIndex+100];
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    self.lineImageView.frame = CGRectMake(btn.frame.origin.x, 94, btn.frame.size.width, 1);
    UICollectionView *collectionView = (UICollectionView *)[self.view viewWithTag:self.seclectIndex+10];
    [collectionView reloadData];
}
@end
