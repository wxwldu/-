//
//  ChangePasswordViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/25.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "MBPConfig.h"
#import "Appcommon.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MBProgressHUD.h"
#import "UserMessage.h"
#import "UIButton+Bootstrap.h"
#import "Common.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改密码";
    [self setBackButton];
    
    [self.ChangePasswordButton normalStyle];

    [self initialTextField:self.OldPassword AndTitle:@"请输入原密码"];
    [self.OldPassword setDelegate:self];
    [self initialTextField:self.NewPassword AndTitle:@"请输入新密码"];
    [self.NewPassword setDelegate:self];
    [self initialTextField:self.CopyNewPassword AndTitle:@"请再次输入新密码"];
    [self.CopyNewPassword setDelegate:self];
    
    
//    UIButton *accessroyButton =[UIButton buttonWithType:UIButtonTypeCustom];
//    accessroyButton.frame = CGRectMake((SCREENWIDTH-200)/2.0, 350, 200, 40) ;
//    [accessroyButton setTitle:@"修改密码" forState:UIControlStateNormal];
//    [accessroyButton setBackgroundColor:PorjectGreenColor];
//    accessroyButton.layer.masksToBounds = YES;
//    accessroyButton.layer.cornerRadius = 8;
//    
//    [accessroyButton addTarget:self action:@selector(clickChangePasswordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:accessroyButton];
    
    
    
}

-(IBAction)clickChangePasswordButtonAction:(id)sender{
    
    if (self.OldPassword.text.length ==0 ||self.NewPassword.text.length ==0 ||self.CopyNewPassword.text.length == 0) {
        ALERTView(@"请正确输入密码");
        
        return;
    }
    if (![self.NewPassword.text isEqualToString:self.CopyNewPassword.text]) {
        ALERTView(@"您两次输入的密码不相同");
        
        return;
    }
    
    //修改密码接口
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        
        
        //
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:[UserMessage md5:self.OldPassword.text] forKey:@"old_password"];
        [parameter setObject:[UserMessage md5:self.NewPassword.text] forKey:@"new_password"];
        [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"phone_number"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPUpdatePassword] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            id resultResponse =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            if ([resultResponse isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 0) {
                    
                    ALERTView(@"修改成功");
                    [[NSUserDefaults standardUserDefaults] setObject:self.CopyNewPassword.text forKey:KUserPassword];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
//                    [self.navigationController popViewControllerAnimated:YES];
                    
                }else if (statusValue == 100)  {
                    ALERTView(@"输入手机号不合法");
                }else if (statusValue ==101)  {
                    ALERTView(@"输入旧密码不合法");
                }else  if (statusValue ==103)  {
                    ALERTView(@"输入新密码不合法");
                }else if (statusValue ==200)  {
                    ALERTView(@"原密码错误");
                }else  if (statusValue ==201)  {
                    ALERTView(@"用户不存在");
                }else if (statusValue ==205)  {
                    ALERTView(@"新密码与原密码相同");
                }else  if (statusValue ==206)  {
                    ALERTView(@"更新失败");
                }
            
                
                
            }
//            else if([resultResponse isKindOfClass:[NSArray class]]){
//                NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            }
        
            
            
        
        
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
        
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];
    
    
    
    
    
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
