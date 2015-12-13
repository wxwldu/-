//
//  ServiceAgreementViewController.m
//  标会记账本
//
//  Created by Siven on 15/9/28.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "ServiceAgreementViewController.h"
#import "MBPConfig.h"

@interface ServiceAgreementViewController ()

@end

@implementation ServiceAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.barTintColor = PorjectGreenColor;
    self.hidesBottomBarWhenPushed = YES;
    [self setBackButton];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.myAgreementWebView setTransform:CGAffineTransformMakeScale(1.5, 1.5)];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (_indexValue == 0) {
         self.title = @"服务协议";
        NSString*path=[[NSBundle mainBundle]pathForResource:@"Agreement"ofType:@"pdf"];
        NSURL*url=[NSURL  fileURLWithPath:path];//创建URL
        NSURLRequest *requestURl=[NSURLRequest requestWithURL:url];//创建NSURLRequest
        [self.myAgreementWebView loadRequest:requestURl];
        
    }else if (_indexValue == 1) {
        self.title = @"操作规则";
        NSString*path=[[NSBundle mainBundle]pathForResource:@"operatingRules"ofType:@"pdf"];
        NSURL*url=[NSURL  fileURLWithPath:path];//创建URL
        NSURLRequest *requestURl=[NSURLRequest requestWithURL:url];//创建NSURLRequest
        [self.myAgreementWebView loadRequest:requestURl];
        
   }else if (_indexValue == 2) {
        self.title = @"常见问题";
        NSString*path=[[NSBundle mainBundle]pathForResource:@"commonProblem"ofType:@"pdf"];
        NSURL*url=[NSURL  fileURLWithPath:path];//创建URL
        NSURLRequest *requestURl=[NSURLRequest requestWithURL:url];//创建NSURLRequest
        [self.myAgreementWebView loadRequest:requestURl];
      
    }
    
}
#pragma mark  ---  NSURLConnectionDataDelegate

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
}
-(IBAction)comebackButtonAction:(id)sender{
    if (_indexValue == 0) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    } else if (_indexValue == 1 || _indexValue == 2){
        [self.navigationController popViewControllerAnimated:YES];
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
