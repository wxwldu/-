//
//  HeadBidTableViewCell.m
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "HeadBidTableViewCell.h"
#import "MBPConfig.h"
#import "UIButton+Bootstrap.h"

@implementation HeadBidTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.myBackgroundView.layer.cornerRadius = 6;
//    self.myBackgroundView.layer.masksToBounds = YES;
//    self.myBackgroundView.layer.borderWidth = 1;
//    self.myBackgroundView.layer.borderColor =[UIColor grayColor].CGColor;
    
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 9;
//    self.frame = CGRectMake(15, 15, SCREENWIDTH-30, self.frame.size.height -30);
    
    
    
//    UIButton *accessroyButton =[UIButton buttonWithType:UIButtonTypeCustom];
//    accessroyButton.frame = CGRectMake(self.frame.size.width-150, (self.frame.size.height-30)/2.0, 70, 30) ;
//    [accessroyButton setTitle:@"标详情" forState:UIControlStateNormal];
//    [accessroyButton setBackgroundColor:PorjectGreenColor];
//    accessroyButton.layer.masksToBounds = YES;
//    accessroyButton.layer.cornerRadius = 8;
//    
////    [accessroyButton addTarget:self action:@selector(clickDetailButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.accessoryView = accessroyButton;
    
    
//    self.detailLabel.layer.cornerRadius = 6;
//    self.detailLabel.layer.masksToBounds = YES;
    //    self.detailLabel.layer
    
    [self.contentView.layer setMasksToBounds:YES];
    [self.contentView.layer setCornerRadius:10];
//    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    [self.detailButton normalStyle];
    
    
}

- (IBAction)downAction:(id)sender {
    if (self.downCellDelegate && [self.downCellDelegate respondsToSelector:@selector(dropDownCellMethod:)]) {
        [self.downCellDelegate dropDownCellMethod:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
