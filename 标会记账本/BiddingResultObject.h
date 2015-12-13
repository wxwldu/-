//
//  BiddingResultObject.h
//  标会记账本
//
//  Created by Siven on 15/10/29.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

//"number": "第几期",
//"biddenMoney": "标金",（还未开标则为空串）
//"totalMoney": "总会款",（还未开标则为空串）
//"name": "中标人名字",（还未开标则为空串）
//"participantId": "中标人id",（还未开标则为空串）
//"cycleId": " 周期id",
//"isOpen": " 是否开标"（0表示未开标，1表示已开标）,
//"date": " 开标日期"（年月日）


#import <Foundation/Foundation.h>

@interface BiddingResultObject : NSObject

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



-(id)initWith:(NSDictionary *)aDictObejct;


@end
