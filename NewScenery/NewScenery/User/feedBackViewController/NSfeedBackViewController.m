//
//  NSfeedBackViewController.m
//  NewScenery
//
//  Created by mac on 16/2/17.
//  Copyright (c) 2016年 Vincent Yang. All rights reserved.
//

#import "NSfeedBackViewController.h"

@interface NSfeedBackViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property (nonatomic ,strong)UILabel *placeholderLabel;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UITextView *textView;

@end

@implementation NSfeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI{
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    UIView *begView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 100)];
    begView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:begView];
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, [UIScreen mainScreen].bounds.size.width-20, 21)];
    self.placeholderLabel.text = @"  请输入您的宝贵意见";
    self.placeholderLabel.font = [UIFont systemFontOfSize:15];
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
    self.placeholderLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.placeholderLabel];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 100)];
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.textColor = [UIColor lightGrayColor];
    self.textView.layer.borderWidth = 0.3;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textView.delegate = self;
    self.textView.returnKeyType = UIReturnKeyDefault;
    [self.view addSubview:self.textView];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 130, [UIScreen mainScreen].bounds.size.width-20, 30)];
    self.textField.placeholder = @"联系方式";
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.borderStyle = UITextBorderStyleNone;
    self.textField.layer.borderWidth = 0.3;
    self.textField.font = [UIFont systemFontOfSize:15];
    self.textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textField.delegate = self;
    [self textFieldFrameWithPadding:10];
    [self.view addSubview:self.textField];
    //navigationItem
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(feedBack)];
}

- (void)feedBack{
    if (self.textView.text.length!=0&&![self.textView.text isEqualToString:@"\n"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self alertView:@"内容不能为空"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"意见反馈";
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
//设置textfield的光标位置
-(void)textFieldFrameWithPadding:(CGFloat)padding
{
    CGRect frame = self.textField.frame;
    frame.size.width = padding;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = leftview;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (text.length!=0&&![text isEqualToString:@"\n"]) {
         self.placeholderLabel.hidden = YES;
    }else{
         self.placeholderLabel.hidden = NO;
    }
    if ([text isEqualToString:@"\n"]) {
       [textView resignFirstResponder];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.text.length!=0&&![textView.text isEqualToString:@"\n"]) {
        self.placeholderLabel.hidden = YES;
    }else{
        self.placeholderLabel.hidden = NO;
    }
    return YES;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
        
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    if ([self validateMobile:textField.text] == 0) {
        [self alertView:@"请输入正确的电话号码"];
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
