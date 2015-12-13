//
//  FindPasswordViewController.m
//  标会记账本
//
//  Created by Siven on 15/10/9.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "FindPasswordViewController.h"

@interface FindPasswordViewController ()<UIAlertViewDelegate>

@end

@implementation FindPasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回密码";
//    [self setBackButton];
    
    [self initialTextField:self.myNewPassword AndTitle:@"设置您的登录密码"];
    [self.myNewPassword setDelegate:self];
    [self initialTextField:self.myPasswordField AndTitle:@"确认您的登录密码"];
    [self.myPasswordField setDelegate:self];
    
    [self.mySubmitButton normalStyle];
}


- (IBAction)myFindPasswordAction:(id)sender {
    
    if (self.myPasswordField.text.length ==0 ||self.myNewPassword.text.length == 0) {
        ALERTView(@"不为空");
        
    }else if (![self.myNewPassword.text isEqualToString:self.myPasswordField.text]){
        ALERTView(@"两次输入密码不正确");
    }
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[UserMessage md5:self.myNewPassword.text] forKey:@"password"];
        [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"phone_number"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:AppModifyPassword] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            id resultResponse =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([resultResponse isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 0) {
                    UIAlertView *aAlertView =[[UIAlertView alloc] initWithTitle:@"重置成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    aAlertView.tag = 1004;
                    [aAlertView show];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:self.myNewPassword.text forKey:KUserPassword];

                    
                    //                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else if (statusValue == 100)  {
                    ALERTView(@"输入手机号不合法");
                }else   if (statusValue ==103)  {
                    ALERTView(@"输入新密码不合法");
                }else  if (statusValue ==201)  {
                    ALERTView(@"用户不存在");
                }else if (statusValue ==205)  {
                    ALERTView(@"重置密码与原密码相同");
                }
                
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
        
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1004) {
        if (buttonIndex == 0) {
//            [self.navigationController popToRootViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }
}

- (void)initialTextField:(UITextField *)textField AndTitle:(NSString *)title
{
    textField.layer.cornerRadius = 6.0f;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.placeholder =title; //请输入新密码 请再次输入新密码
    // textField.textAlignment = NSTextAlignmentLeft;  default
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.layer.borderWidth = 1.5f;
    textField.layer.borderColor = [MBPGreenColor CGColor];
}


#pragma mark - UITextFieldDelegate
// 获取第一响应者时调用
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //    textField.layer.cornerRadius = 8.0f;
    // textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[MBPGreenColor CGColor];
    return YES;
}

// 失去第一响应者时调用
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    textField.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    return YES;
}

// 按enter时调用
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
