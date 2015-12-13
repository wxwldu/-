//
//  CycleSettingDetailFootViewController.h
//  标会记账本
//
//  Created by Siven on 15/11/14.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface CycleSettingDetailFootViewController : BaseProjectViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIButton *saveFootBidButton;
@property (strong, nonatomic) IBOutlet UIView *saveCycleBidView;

//周期设定－确认
@property (strong, nonatomic) IBOutlet UITableView *mytableView;
@property (strong, nonatomic) IBOutlet UIView *myCycleHeadView;

@property (nonatomic) int allCount; //总名数
@property (nonatomic, strong) NSString *dateString; //日期


@property (nonatomic, strong) NSMutableArray *myCycleSettingData;//上一界面h会脚信息传值
@property (nonatomic, strong) NSDictionary *myDetailBidData;//标基本信息传值


@end
