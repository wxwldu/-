//
//  BidDownTableViewCell.m
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BidDownTableViewCell.h"
#import "MBPConfig.h"
#import "UIButton+Bootstrap.h"
#import "Appcommon.h"

@implementation BidDownTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView.layer setMasksToBounds:YES];
    [self.contentView.layer setCornerRadius:8];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.editButton normalStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickDownAction:(id)sender {
    
//    if (self.valueGame ==1) {
//        self.valueAlarmLabel.textColor = [UIColor blackColor];
//        self.AlarmLabel.textColor =[UIColor blackColor];
//        self.editButton.hidden = NO;
//    }else{
//        self.valueAlarmLabel.textColor = MBPGreenColor;
//        self.AlarmLabel.textColor = MBPGreenColor;
//        self.editButton.hidden = YES;
//    }

    
    UIButton *aButton =(UIButton *)sender;
    if (self.bidDownCellButtonDelegate && [self.bidDownCellButtonDelegate respondsToSelector:@selector(clickBidDownCellMethod:)]) {
        [self.bidDownCellButtonDelegate clickBidDownCellMethod:aButton.tag];
    }
}

@end
