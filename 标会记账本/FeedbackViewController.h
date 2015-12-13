//
//  FeedbackViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/20.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface FeedbackViewController : BaseProjectViewController<UITextViewDelegate>


@property (strong, nonatomic) IBOutlet UITextView *feedBackTextView;

@end
