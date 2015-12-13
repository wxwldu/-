//
//  FootBidTableViewCell.h
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FootBidTableViewCell;
@protocol FootBidTableViewCellDelegate <NSObject>

- (void)dropDownCellMethod:(FootBidTableViewCell *)cell;

@end



@interface FootBidTableViewCell : UITableViewCell
@property (nonatomic, weak) id <FootBidTableViewCellDelegate> downCellDelegate;


@property (strong, nonatomic) IBOutlet UILabel *nameBidLabel;
@property (strong, nonatomic) IBOutlet UILabel *amountBidLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateBidLabel;
@property (strong, nonatomic) IBOutlet UIButton *detailButton;

@property (strong, nonatomic) IBOutlet UILabel *detailLabel;


@property (strong, nonatomic) IBOutlet UIView *myBackgroundView;


- (IBAction)downAction:(id)sender;
@end
