//
//  BidDownTableViewCell.h
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BidDownTableViewCell;
@protocol BidDownCellButtonDelegate <NSObject>

- (void)clickBidDownCellMethod:( int )row;

@end


@interface BidDownTableViewCell : UITableViewCell

@property (nonatomic,weak) id<BidDownCellButtonDelegate> bidDownCellButtonDelegate;
@property (nonatomic) int valueGame; //0会脚 1会头
@property (strong, nonatomic) IBOutlet UILabel *cycleNumberLabel;

@property (strong, nonatomic) IBOutlet UILabel *participantNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *biddingMethodLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueAlarmLabel; //不提醒
@property (strong, nonatomic) IBOutlet UILabel *AlarmLabel; //开标提醒

@property (strong, nonatomic) IBOutlet UIButton *topLineInterestButton;
@property (strong, nonatomic) IBOutlet UIButton *bottomLineInterestButton;
@property (strong, nonatomic) IBOutlet UIButton *startTimeButton;

@property (strong, nonatomic) IBOutlet UIButton *editButton; //编辑按钮
@end
