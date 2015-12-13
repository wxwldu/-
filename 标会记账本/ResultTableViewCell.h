//
//  ResultTableViewCell.h
//  标会记账本
//
//  Created by Siven on 15/9/26.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *recordButton;



@property (strong, nonatomic) IBOutlet UILabel *myNumberLabel;
//@property (strong, nonatomic) IBOutlet UILabel *myBiddenMoney;
@property (strong, nonatomic) IBOutlet UILabel *totalMoneyLabel;
//@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UIButton *myBiddenMoneyButton;
@property (strong, nonatomic) IBOutlet UIButton *nameLabelButton;
@end

