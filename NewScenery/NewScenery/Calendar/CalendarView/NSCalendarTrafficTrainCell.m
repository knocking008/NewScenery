//
//  NSCalendarTrafficTrainCell.m
//  NewScenery
//
//  Created by mac on 16/1/23.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSCalendarTrafficTrainCell.h"

@implementation NSCalendarTrafficTrainCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)fullCellWithNSDaliysTrafficModel:(NSDaliysTrafficModel *)model
{
    self.daliy_timeLabel.text = model.daliy_time_text;
    self.number_flightLabel.text = model.number_flight;
    self.start_cityLabel.text = model.start_city;
    self.start_city_enLabel.text = model.start_city_en;
    self.target_cityLabel.text = model.target_city;
    self.start_timeLabel.text = model.start_time;
    self.arrive_timeLabel.text = model.arrive_time;
    self.daliy_date1.text = [self getDateByDateStr:model.daliy_date];
    self.daliy_date2.text = [self getDateByDateStr:model.daliy_date];
    self.daliy_noteLabel.text = model.daliy_note;
}

//将2015.07.06转化为07月06日 星期一
- (NSString *)getDateByDateStr:(NSString *)str
{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *date1 = [dateformatter dateFromString:str];
    [dateformatter setDateFormat:@"MM月dd日 EEEE"];
    NSString *  weekString = [dateformatter stringFromDate:date1];
    return weekString;
}
@end
