//
//  NSRouteTrafficCell.m
//  NewScenery
//
//  Created by mac on 16/1/19.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSRouteTrafficCell.h"

@implementation NSRouteTrafficCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)fullCellWithNSRouteTrafficModel:(NSRouteTrafficModel *)model
{
    self.distanceLabel.text = [NSString stringWithFormat:@"距离%f公里",[self distanceBetweenOrderBy:[model.start_lat doubleValue]:[model.target_lat doubleValue]:[model.start_lng doubleValue]:[model.target_lng doubleValue]]];
    self.numberFlightLabel.text = model.number_flight;
    self.startCittyLabel.text = model.start_city;
    self.startTimeLabel.text = model.start_time;
    self.targetCityLabel.text = model.target_city;
    self.arriveTimeLabel.text = model.arrive_time_text;
    
    self.noteLabel.text = model.daliy_note;
    if (model.daliy_note.length !=0) {
        self.noteLabel.hidden = NO;
        self.NoteShowBeg.hidden = NO;
    }else{
        self.noteLabel.hidden = YES;
        self.NoteShowBeg.hidden = YES;
    }
}

- (double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2
{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //返回 km
    return   distance/1000;
}
@end
