//
//  ServiceAgreementViewController.h
//  标会记账本
//
//  Created by Siven on 15/9/28.
//  Copyright (c) 2015年 SivenWu. All rights reserved.
//

#import "BaseProjectViewController.h"

@interface ServiceAgreementViewController : BaseProjectViewController<NSURLConnectionDataDelegate>


@property ( nonatomic) int indexValue;  //0注册协议 1操作规则 2 常见问题
@property (strong, nonatomic) IBOutlet UIWebView *myAgreementWebView;

@end
