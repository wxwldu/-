//
//  BeginBidViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/22.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"


@interface BeginBidViewController : BaseProjectViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UISegmentedControl *showAllForFoot;  //对会脚可见

//@property (strong, nonatomic) IBOutlet UIButton *showBitFootButton;

@property (strong, nonatomic) IBOutlet UITextField *nameBid;
@property (strong, nonatomic) IBOutlet UITextField *firstMoney;
@property (strong, nonatomic) IBOutlet UITextField *highIncome;
@property (strong, nonatomic) IBOutlet UITextField *lowIncome;

@property (strong, nonatomic) IBOutlet UIButton *chooseWayButton;
@property (strong, nonatomic) IBOutlet UIButton *dateChooseButton;
@property (strong, nonatomic) IBOutlet UIButton *startBidButton;


@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;


@property (strong, nonatomic) NSMutableDictionary *myDataBidDetail; //传值
@property (nonatomic) int indexValue; //0起会 1编辑会

@end
