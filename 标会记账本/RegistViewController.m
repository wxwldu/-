//
//  RegistViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/27.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "RegistViewController.h"
#import "MBPConfig.h"
#import "UIButton+Bootstrap.h"
#import "ServiceAgreementViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "Appcommon.h"
#import "FindPasswordViewController.h"


#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDK+AddressBookMethods.h>
#import <SMS_SDK/SMSSDK+DeprecatedMethods.h>
#import <SMS_SDK/SMSSDK+ExtexdMethods.h>



@interface RegistViewController ()<UIAlertViewDelegate>{
    
     int secondsCountDown ;
    NSTimer *countDownTimer;
}

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     secondsCountDown = 60;
    
    [self.myCodeSendButton normalStyle];
    
    [self initialTextField:self.myPhone AndTitle:@"请输入您的手机号"];
    [self initialTextField:self.myCodePhone AndTitle:@"请输入验证码"];
    [self.myCodePhone setDelegate:self];
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: YES];
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone];
    NSString *passwordUser = [[NSUserDefaults standardUserDefaults] objectForKey:KUserPassword];
    if (phoneNumber.length != 0 && passwordUser.length != 0) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
    
    if(_index == 0){
        self.title = @"标会";
        
        [self.myRegisterButton normalStyle];
        [self.myRegisterButton setTitle:@"注册" forState:UIControlStateNormal];
        [self initialTextField:self.myPhone AndTitle:@"请输入手机号"];
        [self.myPhone setDelegate:self];
        [self initialTextField:self.myPassword AndTitle:@"请输入密码"];
        [self.myPassword setDelegate:self];
        
        self.myAgreeButton.hidden = NO;
        self.myPassword.hidden = NO;
    }else{
        self.title = @"找回密码";
        [self.myRegisterButton normalStyle];
        [self.myRegisterButton setTitle:@"重置密码" forState:UIControlStateNormal];
        
        self.myAgreeButton.hidden = YES;
        self.myPassword.hidden = YES;
    }
    
    

}




- (IBAction)myAgreeButton:(id)sender {
    
    ServiceAgreementViewController *serviceAgreement =[[ServiceAgreementViewController alloc]init];
    [self presentViewController:serviceAgreement animated:YES completion:nil];
    
}
-(IBAction)comebackButtonAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
    //验证号码
    //验证成功后 获取通讯录 上传通讯录
    [self.view endEditing:YES];
    
    if(self.myCodePhone.text.length != 4)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"验证码不正确"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else
    {
        [SMSSDK commitVerificationCode:self.myCodePhone.text phoneNumber:self.myPhone.text zone:@"86" result:^(NSError *error) {
            
            if (!error) {
                
                NSLog(@"验证成功");
                
                //注册界面
                if (_index == 0) {
                    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
                    [parameter setObject:[UserMessage md5:self.myPassword.text] forKey:@"password"];
                    [parameter setObject:self.myPhone.text forKey:@"phone_number"];
                    
                    
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    
                    [manager POST:[APPBaseURL stringByAppendingString:APPRegister] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
                        NSDictionary *responseDic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        int staus  =[[responseDic objectForKey:@"staus"] intValue];
                        if (staus == 0) {
                            
                            //
                            [[NSUserDefaults standardUserDefaults] setObject:self.myPassword.text forKey:KUserPassword];
                            [[NSUserDefaults standardUserDefaults] setObject:self.myPhone.text forKey:KUserPhone];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            
                            UIAlertView *aAlertView =[[UIAlertView alloc]initWithTitle:@"注册成功" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            aAlertView.tag = 0;
                            [aAlertView show];
                            
                        } else if(staus == 100){
                            ALERTView(@"输入手机号不合法");
                        }else if(staus == 103){
                            ALERTView(@"输入新密码不合法");
                        }else if(staus == 202){
                            ALERTView(@"用户已存在");
                        }
                        
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"error");
                    }];
                } else {
//                    [self dismissViewControllerAnimated:NO completion:nil];
                    
                    //找回密码
                    [[NSUserDefaults standardUserDefaults] setObject:self.myPhone.text forKey:KUserPhone];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    FindPasswordViewController *aFindVC =[[FindPasswordViewController alloc] init];
                    
                    [self presentViewController:aFindVC animated:YES completion:nil];
                    
                }
                
            }
            else
            {
                NSLog(@"验证失败");
                
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                                message:@"验证失败"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
                alert.tag = 0004;
                [alert show];
                
                return ;
                
            }
        }];
    }

}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 0) {
        if (buttonIndex == 0) {

            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate.window setRootViewController:appDelegate.tabBarController];
            
//            [[[AppDelegate sharedDelegate] tabBarController] selectedViewController];
//            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

-(IBAction)clickSendCodeButtonAction:(id)sender{
//    [self timemoutHandleAction:nil];//倒计时
    [self handleTimeoutAction];
    
    //发送验证码
    if (self.myPhone.text.length!=11)
    {
        //手机号码不正确
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"请输入正确的手机号"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        alert.tag = 0001;
        [alert show];
        return;
        
    }

    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.myPhone.text
                                   zone:@"86"
                       customIdentifier:nil
                                 result:^(NSError *error)
     {
         
         if (!error)
         {
             NSLog(@"验证码发送成功");

         }
         else
         {
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                             message:[NSString stringWithFormat:@"错误描述：%@",[error.userInfo objectForKey:@"getVerificationCode"]]
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                   otherButtonTitles:nil, nil];
             [alert show];
         }
         
     }];


}
-(void)handleTimeoutAction{
//    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(secondsCountDown <=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.myCodeSendButton setEnabled:YES];
                [self.myCodeSendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
            });
        }else{
//            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d秒重新获取",secondsCountDown];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                [self.myCodeSendButton setEnabled:NO];
                [self.myCodeSendButton setTitle:strTime forState:UIControlStateNormal];
                
                
            });
            secondsCountDown --;
            
        }
    });
    dispatch_resume(_timer);
    
}

-(void)timemoutHandleAction:(id)sender{
    
    
    NSString *timeString =[NSString stringWithFormat:@"%d秒重新获取",secondsCountDown];
    [self.myCodeSendButton setTitle:timeString forState:UIControlStateNormal];
    [self.myCodeSendButton setEnabled:NO];
    
    
    countDownTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
}

-(void)timeFireMethod{
    secondsCountDown--;
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        
        [self.myCodeSendButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self.myCodeSendButton setEnabled:YES];
    }
    

    
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
