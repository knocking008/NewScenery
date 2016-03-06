//
//  NSActionViewController.m
//  NewScenery
//
//  Created by mac on 16/1/13.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSActionViewController.h"
#import "NSHTTPTool.h"
#import "NSActionCollectionViewCell.h"
#import "NSMoreDetailViewController.h"

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
static NSString *NSActionCollectionViewCellID = @"NSActionCollectionViewCell";
@interface NSActionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation NSActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"活动";
    [self getNetDatas];
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)initUI
{
    self.dataArray = [NSMutableArray new];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSActionCollectionViewCellID bundle:nil] forCellWithReuseIdentifier:NSActionCollectionViewCellID];
}

- (void)getNetDatas{
    
    [NSHTTPTool ActionGetNetData:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        [self.collectionView reloadData];
        if (self.dataArray.count==0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self noAction];
            });
        }
    } error:^(NSError *error) {
        NSLog(@"ActionGetNetData------------>%@",error);
    }];
}
- (void)noAction
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake(kWidth/2-50, 200, 100, 100)];
    imageView.image = [UIImage imageNamed:@"noOrder"];
    [self.view addSubview:imageView];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(kWidth/2-50, 311, 100, 30)];
    label.text = @"还没有活动哦";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSActionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSActionCollectionViewCellID forIndexPath:indexPath];
    NSActionModel *model = self.dataArray[indexPath.row];
    [cell fullCellWithActionModel:model];
    return cell;
}
#pragma maek - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(355, 350);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

        NSActionModel *model = self.dataArray[indexPath.row];
        NSMoreDetailViewController *MDVC = [[NSMoreDetailViewController alloc] init];
        MDVC.MoreDetailViewUrlstr = model.url;
        [self.navigationController pushViewController:MDVC animated:YES];
  
}
@end
