//
//  NSSatisfiedCell.h
//  NewScenery
//
//  Created by mac on 16/1/18.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSSatisfiedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIProgressView *routeProView;
@property (weak, nonatomic) IBOutlet UIProgressView *serviceProView;
@property (weak, nonatomic) IBOutlet UIProgressView *efficiencyProView;
@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *efficiencyLabel;

- (void)fullCellWithSatisfied:(NSArray *)satisfied;

@end
