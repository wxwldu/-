//
//  FootBidTableViewCell.m
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "FootBidTableViewCell.h"
#import "MBPConfig.h"
#import <QuartzCore/QuartzCore.h>
#import "UIButton+Bootstrap.h"

@implementation FootBidTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.myBackgroundView.layer.cornerRadius = 6;
//    self.myBackgroundView.layer.masksToBounds = YES;
//    self.myBackgroundView.layer.borderWidth = 1;
//    self.myBackgroundView.layer.borderColor =[UIColor grayColor].CGColor;
    
//    self.layer.masksToBounds = YES;
//    self.layer.cornerRadius = 9;
//    self.frame = CGRectMake(15, 15, SCREENWIDTH-30, self.frame.size.height -30);
    
//    self.backgroundView.backgroundColor = [UIColor whiteColor];
//    NSArray * adddd=[NSArray arrayWithArray:self.subviews];
//    
//    UIView *backgroundView =[[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREENWIDTH-30, self.frame.size.height-30)];
//    backgroundView.layer.masksToBounds = YES;
//    backgroundView.layer.cornerRadius = 8;
//    backgroundView.backgroundColor = [UIColor whiteColor];
////    [backgroundView sendSubviewToBack:self.contentView];
//    [self bringSubviewToFront:backgroundView];
//    
//    
//    self.contentView.backgroundColor = [UIColor lightGrayColor];
    
   
    [self.detailButton normalStyle];
    
}

- (IBAction)downAction:(id)sender {
    if (self.downCellDelegate && [self.downCellDelegate respondsToSelector:@selector(dropDownCellMethod:)]) {
        [self.downCellDelegate dropDownCellMethod:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor =[UIColor whiteColor];
    // Configure the view for the selected state
}

@end
