//
//  NSPhoneServiceViewController.m
//  NewScenery
//
//  Created by mac on 16/1/20.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSPhoneServiceViewController.h"
#import "NSHTTPTool.h"
#import "NSHeaderFile.h"
#import "UWDatePickerView.h"

@interface NSPhoneServiceViewController ()<UITextFieldDelegate,UWDatePickerViewDelegate,UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)UWDatePickerView *pickerView;
@end

@implementation NSPhoneServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self getNetDatas];
}
- (void)initUI{
    self.navigationItem.title = @"预约电话咨询服务";
    self.dataArray = [NSMutableArray new];
    //触摸其他地方收起键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:tap];
    //选择时间
    UITapGestureRecognizer *timeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timeSelectAction)];
    [self.timeView addGestureRecognizer:timeTap];
    //===
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardShowAction:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardHideAction:) name:UIKeyboardWillHideNotification object:nil];
    
    
    self.questtionTF.delegate = self;
    self.nameTF.delegate = self;
    self.nameTF.tag = 10;
    self.phoneTF.delegate = self;
    self.phoneTF.tag = 20;
    self.targetTF.delegate = self;
    self.targetTF.tag = 30;
    
}
- (IBAction)payClick:(id)sender {
    if (self.timeTF.text.length == 0) {
        [self alertView:@"请选择咨询时间"];
        return;
    }
    if (self.targetTF.text.length == 0) {
        [self alertView:@"请输入目的地"];
        return;
    }
    if (self.questtionTF.text.length == 0) {
        [self alertView:@"请选择填写咨询的问题"];
        return;
    }
    if (self.nameTF.text.length == 0) {
        [self alertView:@"请填写您的姓名"];
        return;
    }
    if (self.phoneTF.text.length == 0) {
        [self alertView:@"请选输入您的电话号码"];
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)keyboardShowAction:(NSNotification *)notifi{
       if ([self.phoneTF isFirstResponder]) {//判断是否为第一响应者
        //得到textField的最大边
        CGFloat maxY = CGRectGetMaxY(self.phoneTF.frame);
        //  得到键盘最小边
        NSDictionary *userInfo = notifi.userInfo;
        NSValue *value = userInfo[@"UIKeyboardFrameEndUserInfoKey"];
        CGRect keyboardFrame = [value CGRectValue];//得到键盘的frame
        CGFloat minY = CGRectGetMinY(keyboardFrame);
        if ((maxY -minY) > 0) {
            //      改变self.view的Y坐标
            //      将self.view往上移动
            [UIView animateWithDuration:0.25 animations:^{
                
                CGRect frame = self.view.frame;
                frame.origin.y = minY - maxY;
                self.view.frame = frame;
                
            } completion:nil];
        }
    }
    
    if ([self.nameTF isFirstResponder]) {
        //得到textField的最大边
        CGFloat maxY = CGRectGetMaxY(self.nameTF.frame);
        //  得到键盘最小边
        NSDictionary *userInfo = notifi.userInfo;
        NSValue *value = userInfo[@"UIKeyboardFrameEndUserInfoKey"];
        CGRect keyboardFrame = [value CGRectValue];//得到键盘的frame
        CGFloat minY = CGRectGetMinY(keyboardFrame);
        if ((maxY -minY) > 0) {
            //      改变self.view的Y坐标
            //      将self.view往上移动
            [UIView animateWithDuration:0.25 animations:^{
                
                CGRect frame = self.view.frame;
                frame.origin.y = minY - maxY;
                self.view.frame = frame;
                
            } completion:nil];
        }
    }
    
}
- (void)keyboardHideAction:(NSNotification *)notifi{
    //    恢复view的位置
    self.view.frame = self.view.bounds;
}
- (void)tapAction{
    [self.view endEditing:YES];
}
- (void)getNetDatas{
    [NSHTTPTool ServiceCanPhoneGetNetDatas:^(NSArray *data) {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSCanPhoneModel *model = self.dataArray[[self.designerType intValue]-1];
            self.designerTypeTF.text = model.title;
            self.showpriceLabel.text = [NSString stringWithFormat:@"总价 Ұ%@",model.price];
        });
    } desinerID:self.designerID error:^(NSError *error) {
        NSLog(@"ServiceCanPhoneGetNetDatas---->>%@",error);
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark -UWDatePickerViewDelegate
- (void)timeSelectAction
{
    [self setupDateView:DateTypeOfStart];
}

- (void)setupDateView:(DateType)type {
    
    _pickerView = [UWDatePickerView instanceDatePickerView];
    _pickerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [_pickerView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.1]];
    _pickerView.delegate = self;
    _pickerView.type = type;
    [self.view addSubview:_pickerView];
    
}

- (void)getSelectDate:(NSString *)date type:(DateType)type {
    self.timeTF.text = date;
    
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    if (textField.tag == 20) {
        if ([self validateMobile:textField.text] == 0) {
            [self alertView:@"请输入正确的电话号码"];
        }
    }else if (textField.tag == 10){
        if (textField.text.length!=0&&![textField.text isEqualToString:@"\n"]) {
            
        }else{
            [self alertView:@"用户名不能为空"];
        }
    }else if(textField.tag == 30){
        if (textField.text.length!=0&&![textField.text isEqualToString:@"\n"]) {
            
        }else{
            [self alertView:@"目的地不能为空"];
        }
    }
    return YES;
}
- (void)alertView:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}
//手机号码验证
- (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
@end
