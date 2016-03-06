//
//  NSSkilledCell.m
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSSkilledCell.h"
#import "NSHeaderFile.h"
#define KWidth [UIScreen mainScreen].bounds.size.width
static NSString *ID = @"cell";
@interface NSSkilledCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UICollectionView *collectionView;

@end

@implementation NSSkilledCell

- (void)awakeFromNib {
    // Initialization code
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(0.33*(KWidth-80), 23);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGRect rect = CGRectMake(0, 0, 0, 0);
    self.collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.bounces = NO;
    [self.contentView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)fullCellWithSkill:(NSString *)skill
{
    self.dataArray = [NSMutableArray new];
    NSArray *tmpArr = [skill componentsSeparatedByString:@"·"];
    [self.dataArray addObjectsFromArray:tmpArr];
    CGRect rect = CGRectMake(0, 0, KWidth, [NSDesignerBaseInfoModel HeighForCollectionView:self.dataArray]);
    self.collectionView.frame = rect;
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 23)];
    [btn setBackgroundImage:[UIImage imageNamed:@"boringNormal"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:self.dataArray[indexPath.row] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    btn.layer.borderWidth = 0.8;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.cornerRadius = 11;
    btn.layer.masksToBounds = YES;
    [cell addSubview:btn];
    return cell;
}
@end
