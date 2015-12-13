//
//  BidIncomeAnalyTableViewCell.m
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BidIncomeAnalyTableViewCell.h"
#import "MBPConfig.h"

@implementation BidIncomeAnalyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView.layer  setMasksToBounds:YES];
    [self.contentView.layer setCornerRadius:10];
    self.contentView.backgroundColor = MBPLightGrayColorCopy;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
