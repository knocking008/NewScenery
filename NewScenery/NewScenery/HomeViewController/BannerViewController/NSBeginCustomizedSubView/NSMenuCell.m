//
//  NSMenuCell.m
//  NewScenery
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSMenuCell.h"

@implementation NSMenuCell
{
    UIImageView *filterOrderImageView;
}
- (void)awakeFromNib {
    // Initialization code
    self.freeView.layer.borderWidth = 1.0;
    self.freeView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    
    self.standarView.layer.borderWidth = 1.0;
    self.standarView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    
    self.vipView.layer.borderWidth = 1.0;
    self.vipView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    
    self.plusView.layer.borderWidth = 1.0;
    self.plusView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    
    self.infoView.layer.borderWidth = 1.0;
    self.infoView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;

    filterOrderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.freeView.frame)-8, CGRectGetMaxY(self.freeView.frame)-1, 8, 8)];
    UIImage *theimage = [UIImage imageNamed:@"filterOrder"];
    theimage = [theimage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    filterOrderImageView.image = theimage;
    [self addSubview:filterOrderImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullMenuCellWithNSServicePackageModel:(NSServicePackageModel *)model
{
    self.priceLabel.text = model.price_text;
    if ([model.member_max intValue] > 8) {
        self.numbersLabel.text = @"9-99人";
    }else{
        self.numbersLabel.text = @"1-8人";
    }
    self.designerLabel.text = model.designer_text;
    if ([model.booking intValue] >1) {
        self.bookingLabel.text = @"NO";
    }else{
        self.bookingLabel.text = @"YES";
    }
    
    if ([model.route_book intValue] >1) {
        self.route_bookLabel.text = @"NO";
    }else{
        self.route_bookLabel.text = @"YES";
    }
    if ([model.can_call intValue] >1) {
        self.can_callLabel.text = @"NO";
    }else{
        self.can_callLabel.text = @"YES";
    }
    static int count = 0;
    count++;
    UITapGestureRecognizer *freeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(freeTapAction)];
    [self.freeView addGestureRecognizer:freeTap];
    
    UITapGestureRecognizer *standarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(standarTapAction)];
    [self.standarView addGestureRecognizer:standarTap];
    
    UITapGestureRecognizer *plusTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(plusTapAction)];
    [self.plusView addGestureRecognizer:plusTap];
    
    UITapGestureRecognizer *vipTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(vipTapAction)];
    [self.vipView addGestureRecognizer:vipTap];
    if (count == 1) {
        self.freeView.layer.borderColor = [UIColor cyanColor].CGColor;
    }
}

- (void)freeTapAction{
//    NSLog(@"freeTapAction");
    CGRect rect = CGRectMake(CGRectGetMidX(self.freeView.frame)-8, CGRectGetMaxY(self.freeView.frame)-1, 8, 8);
    filterOrderImageView.frame = rect;
    self.freeView.layer.borderColor = [UIColor cyanColor].CGColor;
    self.standarView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    self.plusView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    self.vipView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"package" object:@"freeTapAction"];
}
- (void)standarTapAction{
//     NSLog(@"standarTapAction");
    CGRect rect = CGRectMake(CGRectGetMidX(self.standarView.frame)-8, CGRectGetMaxY(self.freeView.frame)-1, 8, 8);
    filterOrderImageView.frame = rect;
    self.standarView.layer.borderColor = [UIColor cyanColor].CGColor;
    
    self.freeView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    self.plusView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    self.vipView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"package" object:@"standarTapAction"];
}
- (void)plusTapAction{
//     NSLog(@"plusTapAction");
    CGRect rect = CGRectMake(CGRectGetMidX(self.plusView.frame)-8, CGRectGetMaxY(self.freeView.frame)-1, 8, 8);
    filterOrderImageView.frame = rect;
    self.plusView.layer.borderColor = [UIColor cyanColor].CGColor;
    
    self.standarView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    self.freeView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    self.vipView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"package" object:@"plusTapAction"];
}
- (void)vipTapAction{
//     NSLog(@"vipTapAction");
    CGRect rect = CGRectMake(CGRectGetMidX(self.vipView.frame)-8, CGRectGetMaxY(self.vipView.frame)-1, 8, 8);
    filterOrderImageView.frame = rect;
    self.vipView.layer.borderColor = [UIColor cyanColor].CGColor;
    
    self.standarView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    self.plusView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    self.freeView.layer.borderColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1].CGColor;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"package" object:@"vipTapAction"];
}

@end
