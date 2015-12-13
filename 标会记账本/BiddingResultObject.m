//
//  BiddingResultObject.m
//  标会记账本
//
//  Created by Siven on 15/10/29.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import "BiddingResultObject.h"

@implementation BiddingResultObject
@synthesize number,biddenMoney,totalMoney,name,cycleId,isOpen,date,oldparticipantId,newparticipantId,gameid,biddeninterest,biddingmethod;


-(id)initWith:(NSDictionary *)aDictObejct{
    
//    self =[super self];
//    if (self) {
    
//        _number = [aDictObejct objectForKey:@"number"];
        self.number =[NSString stringWithFormat:@"%@",[aDictObejct objectForKey:@"number"]];
        self.biddenMoney = [aDictObejct objectForKey:@"biddenMoney"];
        self.totalMoney =[aDictObejct objectForKey:@"totalMoney"];
        self.name =[aDictObejct objectForKey:@"name"];
        
        self.cycleId =[aDictObejct objectForKey:@"cycleId"];
        self.isOpen =[aDictObejct objectForKey:@"isOpen"];
        self.date =[aDictObejct objectForKey:@"date"];

        self.oldparticipantId = @"-1";
        self.newparticipantId = @"-1";
        self.gameid =[aDictObejct objectForKey:@"gameid"];
        self.biddingmethod=[aDictObejct objectForKey:@"biddingmethod"];
        self.participantId=[aDictObejct objectForKey:@"participantId"];
        self.biddeninterest = @"";
        
    //        if ([[aDictObejct objectForKey:@"participantId"] length ] !=0) {
    //            self.oldparticipantId =[aDictObejct objectForKey:@"participantId"];
    //        }else{
    //            self.oldparticipantId = @"-1";
    //
    //        }
    
//    }
    
    return self;
}



@end
