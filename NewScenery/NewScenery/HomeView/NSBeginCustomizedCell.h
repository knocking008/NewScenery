//
//  NSBeginCustomizedCell.h
//  NewScenery
//
//  Created by mac on 16/1/14.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"

typedef void(^CallBackBlock)();
@interface NSBeginCustomizedCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *placeName;
@property (nonatomic, copy) CallBackBlock block;
- (void)fullCellWithbPlaceModel:(NSPlaceModel *)model;
@property (weak, nonatomic) IBOutlet UIView *buttomView;

@end
