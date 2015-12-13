//
//  BidGameViewController.m
//  标会记账本
//
//  Created by Siven on 15/10/5.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BidGameViewController.h"
#import "MBPConfig.h"

@interface BidGameViewController ()

@end

@implementation BidGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackButton];
    self.tabBarController.tabBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myIncomeTextFieldChanged:) name:UITextFieldTextDidChangeNotification object:self.myIncomeLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMoneytextFieldChanged:) name:UITextFieldTextDidChangeNotification object:self.myMoneyLabel];
    
    // Do any additional setup after loading the view from its nib.
    self.title = @"竞标";
    self.myIncomeLabel.layer.masksToBounds = YES;
    self.myIncomeLabel.layer.cornerRadius = 8;
    self.myIncomeLabel.layer.borderWidth = 1.5;
    self.myIncomeLabel.layer.borderColor = MBPGreenColor.CGColor;
    

    self.myMoneyLabel.layer.masksToBounds = YES;
    self.myMoneyLabel.layer.cornerRadius = 8;
    self.myMoneyLabel.layer.borderWidth = 1.5;
    self.myMoneyLabel.layer.borderColor = MBPGreenColor.CGColor;
    
    
    [self.myBidGameButton normalStyle];
    
}

- (void)myIncomeTextFieldChanged:(id)sender{
    //计算标金
    if ([[self.bidDetailDictionary objectForKey:@"biddingMethod"] isEqualToString:@"3"]) {
        self.myMoneyLabel.text =[NSString stringWithFormat:@"%d",[[self.bidDetailDictionary objectForKey:@"baselineMoney"] intValue] +[self.myIncomeLabel.text intValue]];
        
    } else {
        self.myMoneyLabel.text =[NSString stringWithFormat:@"%d",[[self.bidDetailDictionary objectForKey:@"baselineMoney"] intValue] -[self.myIncomeLabel.text intValue]];
    }
}
- (void)myMoneytextFieldChanged:(id)sender{
    
    //计算利息
    if ([[self.bidDetailDictionary objectForKey:@"biddingMethod"] isEqualToString:@"3"]) {
        self.myIncomeLabel.text =[NSString stringWithFormat:@"%d", [self.myMoneyLabel.text intValue]-[[self.bidDetailDictionary objectForKey:@"baselineMoney"] intValue]];
        
    } else {
        self.myIncomeLabel.text =[NSString stringWithFormat:@"%d",[[self.bidDetailDictionary objectForKey:@"baselineMoney"] intValue] -[self.myMoneyLabel.text intValue]];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.myIncomeLabel.delegate = self;
    self.myMoneyLabel.delegate = self;
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.myMoneyLabel resignFirstResponder];
    [self.myIncomeLabel resignFirstResponder];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    int incomeInt = [self.myIncomeLabel.text intValue];
    int bidInt =[self.myMoneyLabel.text intValue];
    if (incomeInt!=0&&bidInt!=0) {
        if ([self.myIncomeLabel.text intValue] > [[self.bidDetailDictionary objectForKey:@"topLineInterest"] intValue] || [self.myIncomeLabel.text intValue] < [[self.bidDetailDictionary objectForKey:@"bottomLineInterest"] intValue] ) {
            ALERTView(@"利息应在顶标利息和底标利息之间，否则不合法");
        }

    }
}

- (IBAction)myBidGameAction:(id)sender {
    
    [self ShowBiddingCandidateButtonAction:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//竞标
-(void)ShowBiddingCandidateButtonAction:(id)sender{
    
    if (self.myIncomeLabel.text.length == 0||self.myMoneyLabel.text.length == 0) {
        ALERTView(@"请输入金额");
        return ;
    }
    
    //
    NSMutableDictionary *parameter=[[NSMutableDictionary alloc]init];
    [parameter setObject:self.cycleID forKey:@"cycle_id"];
    [parameter setObject:self.gameID forKey:@"game_id"];
    
    [parameter setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone] forKey:@"phone_number"];
    [parameter setObject:self.myIncomeLabel.text forKey:@"bidding_interest"];
    [parameter setObject:self.myMoneyLabel.text forKey:@"bidding_money"];
    
    NSLog(@"bid result:%@%@?cycle_id=%@&game_id=%@&phone_number=%@&bidding_interest=%@&bidding_money=%@",APPBaseURL,APPBid,self.cycleID,self.gameID,[[NSUserDefaults standardUserDefaults] objectForKey:KUserPhone],self.myIncomeLabel.text,self.myMoneyLabel.text);
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[APPBaseURL stringByAppendingString:APPBid] parameters:parameter  success:^(NSURLSessionDataTask *task, id responseObject) {
        
        id resuldId =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([resuldId isKindOfClass:[NSDictionary class]]) {
            NSDictionary *json =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            int statusValue = [[json objectForKey:@"status"] intValue];
            if (statusValue == 100)  {
                
                ALERTView(@"输入手机号不合法");
                
            } else if (statusValue == 105)  {
                
                ALERTView(@"输入会子id不合法");
                
            }else if (statusValue == 104)  {
                
                ALERTView(@"输入周期id不合法");
                
            } else if (statusValue == 109)  {
                
                ALERTView(@"输入竞标金额不合法");
                
            }else if (statusValue == 110)  {
                
                ALERTView(@"输入竞标利息不合法");
                
            } else if (statusValue == 0)  {
                
//                ALERTView(@"竞标成功");
                UIAlertView *aAlertView =[[UIAlertView alloc]initWithTitle:nil message:@"竞标成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                aAlertView.tag = 1000;
                [aAlertView show];
                
            } else if (statusValue == 208)  {
                
                ALERTView(@"竞标失败，本次竞标金额与上次相同或者竞标者已没有活标");
                
            }
            
        }
        

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error");
    }];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1000) {
        if (buttonIndex == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
