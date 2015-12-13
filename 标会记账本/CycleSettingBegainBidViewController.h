//
//  CycleSettingBegainBidViewController.h
//  标会记账本
//
//  Created by Siven on 15/10/8.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface CycleSettingBegainBidViewController : BaseProjectViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *saveFootBidButton;

@property (strong, nonatomic) IBOutlet UIButton *saveCycleBidButton;
 //周期设定－确认
@property (strong, nonatomic) IBOutlet UITableView *mytableView;


@property (nonatomic) int allCount; //总名数
@property (nonatomic, strong) NSString *dateString; //日期


@end
