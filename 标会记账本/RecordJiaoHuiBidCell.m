//
//  RecordJiaoHuiBidCell.m
//  标会记账本
//
//  Created by Siven on 15/10/23.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import "RecordJiaoHuiBidCell.h"

@implementation RecordJiaoHuiBidCell

- (void)awakeFromNib {
    // Initialization code
    [self.myImageView.layer setMasksToBounds:YES];
    [self.myImageView.layer setBorderColor:PorjectGreenColor.CGColor];
    [self.myImageView.layer setBorderWidth:1.5];
    [self.myImageView.layer setCornerRadius:2.0];

    self.dealOrNotButton.selected = NO;
    if (self.dealOrNotButton.selected) {
        [self.myImageView setImage:[UIImage imageNamed:@"tick.png"]];
        
    }else{

        [self.myImageView setImage:[UIImage imageNamed:@"white.png"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    [self.dealOrNotButton setBackgroundImage:[UIImage imageNamed:@"tick.png"] forState:UIControlStateSelected];
    
    // Configure the view for the selected state
}

@end
