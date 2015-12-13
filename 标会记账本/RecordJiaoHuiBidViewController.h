//
//  RecordFootBidViewController.h
//  标会记账本
//
//  Created by Siven on 15/10/7.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface RecordJiaoHuiBidViewController : BaseProjectViewController<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *myRecodTableHeadView;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;


@property (nonatomic, strong) NSDictionary *recordDictionary; //传值

@property (strong, nonatomic) IBOutlet UIButton *mySaveButton;

@property (strong, nonatomic) IBOutlet UILabel *myNoneLabel;

@end
