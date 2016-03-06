//
//  NSNumberOfPeopleCell.m
//  NewScenery
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSNumberOfPeopleCell.h"

#define Kheight [UIScreen mainScreen].bounds.size.height
#define Kwidth  [UIScreen mainScreen].bounds.size.width
#define KBtnWidth Kwidth/8.0
@implementation NSNumberOfPeopleCell
{
    UIScrollView *scrollView;
    UIButton *numBtn;
    NSInteger btnTag;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Kwidth, 50)];
        btnTag = 1;
        scrollView.scrollEnabled = YES;
        [self addSubview:scrollView];
    }
    
    return self;
}
- (void)fullNumberOfPeopleCell:(int )number
{

    if (number > 8) {
        scrollView.contentSize = CGSizeMake(KBtnWidth*(number-8), 50);
    }else{
        scrollView.contentSize = CGSizeMake(KBtnWidth*number, 50);
    }

    int tmp = 0;
    if (number > 8) {
        tmp = 9;
    }else{
        tmp = 1;
    }
    NSArray *subViews = scrollView.subviews;
    if (subViews.count!=0) {
           for (UIButton *btn in subViews)
           {
               [btn removeFromSuperview];
           }
    }
 

    for (int i = tmp; i <= number; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i>8) {
            btn.frame = CGRectMake((i-9)*KBtnWidth+10, 10, 30, 30);
        }else{
            btn.frame = CGRectMake((i-1)*KBtnWidth+10, 10, 30, 30);
        }
        [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 15;
        btn.layer.masksToBounds= YES;
        
        btn.tag = i;
        [scrollView addSubview:btn];
        if (i == btnTag) {
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor cyanColor].CGColor;
        }
        
    }
}

- (void)btnAction:(UIButton *)sender{
    for (UIButton *btn in scrollView.subviews) {
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = [UIColor cyanColor].CGColor;
    NSNotificationCenter *center  = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"numberOfPeople" object:@(sender.tag)];
    btnTag = sender.tag;
}

@end
