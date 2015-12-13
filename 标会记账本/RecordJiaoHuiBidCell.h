//
//  RecordJiaoHuiBidCell.h
//  标会记账本
//
//  Created by Siven on 15/10/23.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordJiaoHuiBidCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *mynameLabel;

@property (strong, nonatomic) IBOutlet UILabel *bidCountLabel;

@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UIButton *dealOrNotButton;

@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@end
