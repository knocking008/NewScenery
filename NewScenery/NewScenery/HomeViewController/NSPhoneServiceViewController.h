//
//  NSPhoneServiceViewController.h
//  NewScenery
//
//  Created by mac on 16/1/20.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSBaseViewController.h"
@interface NSPhoneServiceViewController : NSBaseViewController

@property (weak, nonatomic) IBOutlet UITextField *designerTypeTF;
@property (weak, nonatomic) IBOutlet UITextField *timeTF;
@property (weak, nonatomic) IBOutlet UITextField *targetTF;
@property (weak, nonatomic) IBOutlet UITextView *questtionTF;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UILabel *showpriceLabel;

@property (nonatomic, strong)NSString *designerID;
@property (nonatomic, strong)NSString *designerType;
@end
