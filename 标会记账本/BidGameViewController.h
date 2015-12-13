//
//  BidGameViewController.h
//  标会记账本
//
//  Created by Siven on 15/10/5.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface BidGameViewController : BaseProjectViewController<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *myIncomeLabel;
@property (strong, nonatomic) IBOutlet UITextField *myMoneyLabel;
@property (strong, nonatomic) IBOutlet UIButton *myBidGameButton;

@property (nonatomic ,strong) NSString  *gameID; //会子ID 传值
@property (nonatomic ,strong) NSString  *cycleID; //周期ID 传值
@property (nonatomic ,strong) NSDictionary  *bidDetailDictionary; //标详情 传值

@end
