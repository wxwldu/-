//
//  resultBiddingObject.m
//  标会记账本
//
//  Created by Siven on 15/10/31.
//  Copyright © 2015年 SivenWu. All rights reserved.
////

// ShowBiddingResult.php
//"number": "第几期",
//"biddenMoney": "标金",（还未开标则为空串）
//"totalMoney": "总会款",（还未开标则为空串）
//"name": "中标人名字",（还未开标则为空串）
//"participantId": "中标人id",（还未开标则为空串）
//"cycleId": " 周期id",
//"isOpen": " 是否开标"（0表示未开标，1表示已开标）,
//"date": " 开标日期"（年月日）

#import "resultBiddingObject.h"

@implementation resultBiddingObject
@synthesize number,biddenMoney,totalMoney,name,oldparticipantId,newparticipantId,cycleId,isOpen,date,biddeninterest,gameid,biddingmethod,baselineMoney,participantId;


-(id)initWithResultDictonary:(NSDictionary *)aDictObejct{
    
    self = [super init];
    
    if(self)
    {
        
        self.number =[aDictObejct objectForKey:@"number"];
        self.biddenMoney = [aDictObejct objectForKey:@"biddenMoney"];
        self.totalMoney =[aDictObejct objectForKey:@"totalMoney"];
        self.name =[aDictObejct objectForKey:@"name"];
        self.cycleId =[aDictObejct objectForKey:@"cycleId"];
        self.isOpen =[aDictObejct objectForKey:@"isOpen"];
        self.date =[aDictObejct objectForKey:@"date"];
        
        NSLog(@"number:%@,and string:%@",self.number,[aDictObejct objectForKey:@"number"]);
        
        
        if ([[aDictObejct objectForKey:@"name"] length ] !=0) {
            self.oldparticipantId =[aDictObejct objectForKey:@"participantId"];
            self.newparticipantId =[aDictObejct objectForKey:@"participantId"];
        }else{
            self.oldparticipantId = @"-1";
            self.newparticipantId = @"-1";
        }
        //    self.oldparticipantId = @"-1";
        //    self.gameid =[aDictObejct objectForKey:@"gameid"];
        //    self.biddingmethod=[aDictObejct objectForKey:@"biddingmethod"];
        //    self.participantId=[aDictObejct objectForKey:@"participantId"];
        //    self.biddeninterest = @"";
        //    
        //    self.currentUsedNumber = @"";

        
    }
    
    
    return self;
}



@end
