//
//  BiddingRecordObjec.h
//  标会记账本
//
//  Created by Siven on 15/11/7.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BiddingRecordObjec : NSObject{
    
     NSString *name;
     NSString *biddingMoney;
     NSString *biddingInterest;
     UIImage *participantId;
    
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *biddingMoney;
@property (nonatomic, retain) NSString *biddingInterest;
@property (nonatomic, retain) UIImage *participantId;

@end
