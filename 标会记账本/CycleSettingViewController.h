//
//  CycleSettingViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"


//选择 竞标方式 －－点击cell时delegate
@class CycleSettingViewController;
@protocol CycleSettingViewControllerCellDelegate <NSObject>

- (void)clickCycleSettingCellMethod:( int ) value;

@end


@interface CycleSettingViewController : BaseProjectViewController<UITableViewDelegate,UITableViewDataSource>{
    
    NSString *_tagString;
}

@property (nonatomic,weak) id<CycleSettingViewControllerCellDelegate> CycleSettingVCCellButtonDelegate;

@property (nonatomic) int indexFrom; //0会脚 1会头
@property (nonatomic) int indexChoosen; //0 周期设定 1会脚详情 2竞标方式

@property (strong, nonatomic) IBOutlet UIView *myCycleView;
@property (strong, nonatomic) IBOutlet UIView *myFootBidView;

@property (strong, nonatomic) IBOutlet UIView *FootBidTableFootView; //会脚详情－添加会脚 确认
@property (strong, nonatomic) IBOutlet UIButton *addFootBidButton; //会脚详情－添加会脚
@property (strong, nonatomic) IBOutlet UIButton *saveFootBidButton; //会脚详情－确认
@property (strong, nonatomic) IBOutlet UIButton *saveCycleBidButton; //周期设定－确认

@property (strong, nonatomic) IBOutlet UITableView *mytableView;

@property (nonatomic, strong) NSDictionary *myBidDetailData; //传值

@end
