//
//  RecordResultBidVC.h
//  标会记账本
//
//  Created by Siven on 15/10/18.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"
#import "BiddingResultObject.h"

@interface RecordResultBidVC : BaseProjectViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *recordtableView;
@property (nonatomic, strong) IBOutlet UIView *headTableView; //头
@property (nonatomic, strong) IBOutlet UIView *footTableView;

@property (strong, nonatomic) NSString *gameID; //传值
@property (strong, nonatomic) BiddingResultObject *aBiddingResultObject; //结果传值

@property (strong, nonatomic) IBOutlet UIButton *scopeButton; //抽签按钮
@property (strong, nonatomic) IBOutlet UILabel *myResultBidLabel; //抽签结果
@property (strong, nonatomic) IBOutlet UILabel *myScopeLabel;//抽签范围显示

@property (nonatomic) int indexFrom; //0会脚 1会头
@end
