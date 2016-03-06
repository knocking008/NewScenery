//
//  NSBannerCell.m
//  NewScenery
//
//  Created by mac on 16/1/12.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSBannerCell.h"
#import "UIImageView+WebCache.h"

#import "Masonry.h"
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height
#define kScrollViewHeight self.scrollView.frame.size.height



@interface NSBannerCell ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, strong)NSMutableArray *imageUrlStrArray;

@end

@implementation NSBannerCell



- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithBannerArray:(NSArray *)array
{
    self.imageUrlStrArray = [NSMutableArray array];
    for (NSBannerModel *obj in array) {
        [_imageUrlStrArray addObject:obj.img];
    }
     if (_imageUrlStrArray&&_imageUrlStrArray.count!=0) {
    //在第一个位置添加冗余的图片,最后一张图片
    UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, kScrollViewHeight)];
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:[_imageUrlStrArray lastObject]] placeholderImage:nil];
    [self.scrollView addSubview:lastImageView];
   
    //真正要显示的图片
    for (int i = 1; i <= _imageUrlStrArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWidth*i, 0, KWidth, kScrollViewHeight)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlStrArray[i-1]] placeholderImage:nil];
            [self.scrollView addSubview:imageView];
    }
   
    //在最后一个位置添加一张冗余的图片，显示第一张图片
    UIImageView *firstImageView =  [[UIImageView alloc] initWithFrame:CGRectMake(KWidth*(_imageUrlStrArray.count+1), 0, KWidth, kScrollViewHeight)];
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:[_imageUrlStrArray firstObject]] placeholderImage:nil];
         [self.scrollView addSubview:firstImageView];
    //滚动范围
    self.scrollView.contentSize = CGSizeMake(KWidth*(_imageUrlStrArray.count+2), kScrollViewHeight);
    self.scrollView.contentOffset = CGPointMake(KWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.tag = 100;
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerTapAction)];
         [self.scrollView addGestureRecognizer:tap];

         UIPageControl *pageContrl = [[UIPageControl alloc] init];
//         WithFrame:CGRectMake(150, 290, 100, 20)];
    [self.contentView addSubview:pageContrl];
         [pageContrl mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(@(130));
             make.right.equalTo(@(-125));
             make.top.equalTo(@(290));
             make.bottom.equalTo(@(-120));
         }];
         
    pageContrl.numberOfPages = _imageUrlStrArray.count;
    pageContrl.currentPage = 0;
    pageContrl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageContrl.pageIndicatorTintColor = [UIColor grayColor];
         [pageContrl addTarget:self action:@selector(pageContrlAction:) forControlEvents:UIControlEventTouchUpInside];
    self.pageControl = pageContrl;
         
    }
    
    //触摸事件
    //电子导游
    UITapGestureRecognizer *ElectronicTourGuideClickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ElectronicTourGuideAction)];
    [self.ElectronicTourGuideClickView addGestureRecognizer:ElectronicTourGuideClickTap];
    //全网比价
    UITapGestureRecognizer *ParityClickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ParityAction)];
    [self.ParityClickView addGestureRecognizer:ParityClickTap];
    //达人定制
    UITapGestureRecognizer *CustomizedClickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CustomizedAction)];
    [self.CustomizedClickView addGestureRecognizer:CustomizedClickTap];
}

//触摸图片事件
- (void)bannerTapAction
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"bannerMassage" object:@"bannerTapAction"];
}

//开始定制
- (IBAction)BeginCustomized:(id)sender {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"bannerMassage" object:@"BeginCustomized"];

}
//什么是定制服务
- (IBAction)QuestionClick:(id)sender {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"bannerMassage" object:@"QuestionClick"];

}
//达人定制
- (void)CustomizedAction {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"bannerMassage" object:@"CustomizedClick"];

}
//全网比价
- (void)ParityAction{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"bannerMassage" object:@"ParityClick"];

}
//电子导游
- (void)ElectronicTourGuideAction{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"bannerMassage" object:@"ElectronicTourGuideClick"];
}

- (void)pageContrlAction:(UIPageControl *)sender
{
    UIScrollView *scrollView = (UIScrollView *)[self viewWithTag:100];
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width * (sender.currentPage+1), 0);
}
#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (page == 0) {
        //跳转到真正的最后一页
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width * _imageUrlStrArray.count, 0);
        self.pageControl.currentPage = _imageUrlStrArray.count;
    }else if(page == _imageUrlStrArray.count+1){
        //跳转到真正的第一页
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
        self.pageControl.currentPage = 0;
    }else{
        self.pageControl.currentPage = page - 1;
    }
    self.count = page;
}


@end
