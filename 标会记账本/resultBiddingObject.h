//
//  resultBiddingObject.h
//  标会记账本
//
//  Created by Siven on 15/10/31.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resultBiddingObject : NSObject

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *biddenMoney;
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *oldparticipantId;
@property (nonatomic, strong) NSString *newparticipantId;

@property (nonatomic, strong) NSString *cycleId;
@property (nonatomic, strong) NSString *isOpen;
@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *biddeninterest;
@property (nonatomic, strong) NSString *gameid;
@property (nonatomic, strong) NSString *biddingmethod;

@property (nonatomic, strong) NSString *baselineMoney;
@property (nonatomic, strong) NSString *participantId;

@property (nonatomic, strong) NSString *currentUsedNumber;

-(id)initWithResultDictonary:(NSDictionary *)aDictObejct;


@end
