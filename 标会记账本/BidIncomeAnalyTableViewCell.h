//
//  BidIncomeAnalyTableViewCell.h
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidIncomeAnalyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *createNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *baselineMoneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *firstDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *outcomeLabel;

@end
