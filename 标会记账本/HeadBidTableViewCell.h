//
//  HeadBidTableViewCell.h
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeadBidTableViewCell;
@protocol HeadBidTableViewCellDelegate <NSObject>

- (void)dropDownCellMethod:(HeadBidTableViewCell *)cell;

@end

@interface HeadBidTableViewCell : UITableViewCell



@property (nonatomic, weak) id <HeadBidTableViewCellDelegate> downCellDelegate;
@property (strong, nonatomic) IBOutlet UILabel *nameBidLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateBidLabel;
@property (strong, nonatomic) IBOutlet UIView *myBackgroundView;
@property (strong, nonatomic) IBOutlet UIButton *detailButton;


- (IBAction)downAction:(id)sender;


@end
