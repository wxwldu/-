//
//  FeedbackViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "FeedbackViewController.h"
#import "MBPConfig.h"
#import "MBProgressHUD.h"
#import "Appcommon.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "UserMessage.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    // Do any additional setup after loading the view from its nib.
    self.title = @"意见反馈";
    [self setBackButton];
    [self initialTextView:self.feedBackTextView];
    [self.feedBackTextView setDelegate:self];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    
    UIButton *accessroyButton =[UIButton buttonWithType:UIButtonTypeCustom];
    accessroyButton.frame = CGRectMake(80, 380, self.view.frame.size.width- 160, 40) ;
    [accessroyButton setTitle:@"提交" forState:UIControlStateNormal];
    [accessroyButton setBackgroundColor:PorjectGreenColor];
    accessroyButton.layer.masksToBounds = YES;
    accessroyButton.layer.cornerRadius = 8;
    [accessroyButton addTarget:self action:@selector(commmitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:accessroyButton];
    


    
}

- (void)initialTextView:(UITextView *)textView
{
    // textView.textAlignment = NSTextAlignmentLeft;  default
    textView.layer.cornerRadius = 8.0f;
    // textView.layer.masksToBounds = YES;
    
    textView.layer.borderWidth= 2.0f;
    textView.layer.borderColor=[MBPGreenColor CGColor];
}


-(void )commmitButton{
    if (self.feedBackTextView.text.length == 0) {
        ALERTView(@"请输入反馈");
        return;
    }
    
    MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.labelText = @"加载...";
    //    HUD.mode = MBProgressHUDModeText;
    [HUD showAnimated:YES whileExecutingBlock:^{
        

        //登录
        NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
        [parameter setObject:self.feedBackTextView.text forKey:@"feedback"];
        [parameter setObject:[[NSUserDefaults standardUserDefaults]objectForKey:KUserPhone] forKey:@"phone_number"];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:[APPBaseURL stringByAppendingString:APPFeedback] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
//            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                int statusValue = [[json objectForKey:@"status"] intValue];
                if (statusValue == 0) {
                    
                    ALERTView(@"成功");
                    
//                    [self.navigationController popViewControllerAnimated:YES];
                }else if (statusValue == 100)  {
                    
                    ALERTView(@"输入手机号不合法");
                    
                }else if (statusValue ==102)  {
                    ALERTView(@"输入反馈不合法");
                }else  if (statusValue ==204)  {
                    ALERTView(@"反馈失败");
                }
                
                
//            }
//            else if([responseObject isKindOfClass:[NSArray class]]){
//                NSArray *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            }
//            
            
            
                   } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"error");
        }];
        
        
    } completionBlock:^{
        
        [HUD removeFromSuperview];
        
    }];

    
    
}


#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    textView.layer.borderColor = [MBPGreenColor CGColor];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    textView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    return YES;
}

#pragma mark - touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in [self.view subviews]) {
        [view resignFirstResponder];
    }
    // [self.view resignFirstResponder];  // No
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
