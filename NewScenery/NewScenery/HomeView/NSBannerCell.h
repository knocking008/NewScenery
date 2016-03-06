//
//  NSBannerCell.h
//  NewScenery
//
//  Created by mac on 16/1/12.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSBannerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *customBtn;

@property (weak, nonatomic) IBOutlet UIView *CustomizedClickView;

@property (weak, nonatomic) IBOutlet UIView *ParityClickView;
@property (weak, nonatomic) IBOutlet UIView *ElectronicTourGuideClickView;

- (void)fullCellWithBannerArray:(NSArray *)array;

@end
