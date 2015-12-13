//
//  recordTableViewCell.h
//  标会记账本
//
//  Created by Siven on 15/9/23.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface recordTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameSelectLabel;
@property (strong, nonatomic) IBOutlet UILabel *scopeSelectLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@property (strong, nonatomic) IBOutlet UIButton *selectButton;


@end
