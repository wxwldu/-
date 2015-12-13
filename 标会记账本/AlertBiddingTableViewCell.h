//
//  AlertBiddingTableViewCell.h
//  标会记账本
//
//  Created by Siven on 15/10/10.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertBiddingTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *nameBidLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountBidLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateBidLabel;

@property (strong, nonatomic) IBOutlet UILabel *alertTimeLabel;


@property (strong, nonatomic) IBOutlet UIView *myBackgroundView;


@end
