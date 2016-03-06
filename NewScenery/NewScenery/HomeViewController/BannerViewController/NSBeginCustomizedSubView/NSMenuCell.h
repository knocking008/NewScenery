//
//  NSMenuCell.h
//  NewScenery
//
//  Created by mac on 16/1/27.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *freeView;
@property (weak, nonatomic) IBOutlet UIView *standarView;
@property (weak, nonatomic) IBOutlet UIView *vipView;
@property (weak, nonatomic) IBOutlet UIView *plusView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
- (void)fullMenuCellWithNSServicePackageModel:(NSServicePackageModel *)model;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel;
@property (weak, nonatomic) IBOutlet UILabel *designerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookingLabel;
@property (weak, nonatomic) IBOutlet UILabel *route_bookLabel;
@property (weak, nonatomic) IBOutlet UILabel *can_callLabel;




@end
