//
//  IncomeAnalysisViewCell.h
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncomeAnalysisViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *myTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *outcomeLabel;

@property (strong, nonatomic) IBOutlet UILabel *profitLabel;
@end
