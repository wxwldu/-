//
//  LoginViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/27.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "LoginViewController.h"
#import "MBPConfig.h"
#import "UIButton+Bootstrap.h"
#import "RegistViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "common.h"
#import "Appcommon.h"
#import "UserMessage.h"
#import "AppDelegate.h"



@interface LoginViewController ()

@end

@implementation LoginViewController




- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor = PorjectGreenColor;
    
   
    self.title = @"标会";
    [self setBackButton];
    
    [self.myLoginButton normalStyle];
    
    [self initialTextField:self.myPhone AndTitle:@"请输入手机号"];
    [self.myPhone setDelegate:self];
    [self initialTextField:self.myPassword AndTitle:@"请输入密码"];
    [self.myPassword setDelegate:self];

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone];
    NSString *passwordUser = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPassword];
    if (phoneNumber.length != 0 && passwordUser.length != 0) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
//        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        [appDelegate.window setRootViewController:appDelegate.tabBarController];
    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.myPhone resignFirstResponder];
    [self.myPassword resignFirstResponder];
    
}
-(IBAction)clickLoginButtonAction:(id)sender{
    
    if (self.myPhone.text.length == 0) {
        ALERTView(@"请输入手机号");
    }else{
        if (self.myPassword.text.length == 0) {
            ALERTView(@"请输入密码");
        } else {
            MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            
            HUD.labelText = @"加载...";
            //    HUD.mode = MBProgressHUDModeText;
            [HUD showAnimated:YES whileExecutingBlock:^{
      
                
            
            //登录
            NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
            NSString *passwordMD5 =[UserMessage md5:self.myPassword.text];
            NSLog(@"md :%@ and%@",passwordMD5,self.myPassword.text);
            [parameter setObject:passwordMD5 forKey:@"password"];
            [parameter setObject:self.myPhone.text forKey:@"phone_number"];
            NSLog(@"diction :%@",parameter);
            
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            NSLog(@"base url :%@",[APPBaseURL stringByAppendingString:APPLogin]);
            [manager POST:[APPBaseURL stringByAppendingString:APPLogin] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
            
                
                    NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                    int statusValue = [[json objectForKey:@"status"] intValue];
                    if (statusValue == 0) {
                        NSUserDefaults *autoLoginUser=[NSUserDefaults standardUserDefaults];
                        [autoLoginUser setObject:self.myPhone.text forKey:KUserPhone];
                        [autoLoginUser setObject:self.myPassword.text forKey:KUserPassword];
                        [autoLoginUser synchronize];
                        [self.tabBarController select:0];
                        
                       
                        
                if (self.selectTag ==1) {
                    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [appDelegate.window setRootViewController:appDelegate.tabBarController];
                }else{
                     [self dismissViewControllerAnimated:YES completion:nil];
                }
                    

                    
                        
                    }else if (statusValue == 100)  {
                        
                        ALERTView(@"输入手机号不合法");
                        
                    }else if (statusValue ==101)  {
                        ALERTView(@"输入密码不合法");
                    }else if (statusValue ==200)  {
                        ALERTView(@"密码错误");
                    }else  if (statusValue ==201)  {
                        ALERTView(@"用户不存在");
                    }
                    
                    
                    
                
                
                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                NSLog(@"error");
            }];
           
            } completionBlock:^{
                
                [HUD removeFromSuperview];
                
            }];
            
            
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

- (IBAction)clickRegistButtonAction:(id)sender {
//    [self dismissViewControllerAnimated:NO completion:nil];
    
    RegistViewController *aRegistVC =[[RegistViewController alloc]init];
    aRegistVC.index = 0;
//    [self.navigationController pushViewController:aRegistVC animated:YES];
    [self presentViewController:aRegistVC animated:YES completion:nil];
    
}
- (IBAction)myForgetPassword:(id)sender {
    RegistViewController *aRegistVC =[[RegistViewController alloc]init];
    aRegistVC.index = 1;
    [self presentViewController:aRegistVC animated:YES completion:nil];
    
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
