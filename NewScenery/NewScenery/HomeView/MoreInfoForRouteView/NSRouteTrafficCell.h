//
//  NSRouteTrafficCell.h
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSHeaderFile.h"
@interface NSRouteTrafficCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *trafficDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberFlightLabel;
@property (weak, nonatomic) IBOutlet UILabel *startCittyLabel;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *arriveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;

- (void)fullCellWithNSRouteTrafficModel:(NSRouteTrafficModel *)model;
@property (weak, nonatomic) IBOutlet UIImageView *NoteShowBeg;


@end
