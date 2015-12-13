//
//  recordFirstTableViewCell.h
//  标会记账本
//
//  Created by Siven on 15/10/2.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recordFirstTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameBidLabel;//竞标人名字
@property (nonatomic, strong) IBOutlet UILabel *biddingMoneyLabel;//标金
@property (nonatomic, strong) IBOutlet UILabel *biddingInterestLabel;//利息


@end
