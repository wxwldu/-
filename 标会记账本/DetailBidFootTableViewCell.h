//
//  DetailBidFootTableViewCell.h
//  标会记账本
//
//  Created by Siven on 15/9/27.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailBidFootTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString  *cellId; //存储电话
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *allCountBidButton;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UIButton *deleteOrNotButton;

@end
