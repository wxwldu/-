//
//  BidCaculatorObject.m
//  标会记账本
//
//  Created by Siven on 15/10/31.
//  Copyright © 2015年 SivenWu. All rights reserved.
//

#import "BidCaculatorObject.h"
#import "resultBiddingObject.h"


@implementation BidCaculatorObject


/**
 * 根据规则、利息计算标金
 * 这边不做数值合法性检测，检测放在调用的外面
 *
 * @param interest
 * @return
 */
//+(int) caculatebidMoneyWithInterest:(int)interest AndbiddingMethod:(int)biddingMethod AndGame:(int)game{
//    int bidMoney = 0;
//    switch (biddingMethod) {
//        case 0:
//        case 1:
//        case 2:
//            bidMoney = Integer.parseInt(game.getBaselineMoney()) - interest;
//            break;
//        case 3:
//            bidMoney = Integer.parseInt(game.getBaselineMoney()) + interest;
//            break;
//    }
//    return bidMoney;
//}

/**
 * 根据规则、标金计算利息
 *
 * @param bidMoney
 * @return
 */
//public static int caculateInterest(int bidMoney, int biddingMethod, Game game) {
//    int interest = 0;
//    switch (biddingMethod) {
//        case 0:
//        case 1:
//        case 2:
//            interest = Integer.parseInt(game.getBaselineMoney()) - bidMoney;
//            break;
//        case 3:
//            interest = bidMoney - Integer.parseInt(game.getBaselineMoney());
//            break;
//    }
//    return interest;
//}



/**
 * 计算某一个周期中，某一个人的死标名数
 * 有别于全局的死标数，此处计算的是累计到第number期的死标数。但是使用的时候又需要注意，对于某一期的中标这个人而言：
 * 他的标名数总数 = 该期中标数（1名） + 这期之前的中标数 + 活标数
 * 前两个数值之和也就是这个方法计算出来的currentUsedNumber
 *
 * @param number
 * @param participant
 * @param bidResults
 */
+(int )caculateCurrentUsedNumberWithnumber:(int )number AndParticipant:(NSDictionary *)participant AndBidResult:(NSArray *)BidResult{
    
    int currentUsedNumber= 0;
    for (int i = 0; i < BidResult.count; ++i) {
        resultBiddingObject  *aBidResultObj =[BidResult objectAtIndex:i];
        NSLog(@"BidResult:%@ andparticipantId:%@",aBidResultObj.participantId,[participant objectForKey:@"participantId"]);
        
        if ([aBidResultObj.newparticipantId isEqualToString:[participant objectForKey:@"participantId"]]) {
            currentUsedNumber = currentUsedNumber +1;
            
        }
        

        if ([aBidResultObj.number intValue] ==number) {
            
            break;
        }
//        if (bidResults.get(i).getNumber().equals(number + "")) {
//            BidLogger.d(TAG + "_CaculateCurrentUsedNumber", participant.getName() + "'s currentUsedNumber = " + participant.getCurrentUsedNumber());
//            break;
        }
    
    return currentUsedNumber;
}


/**
 * 修改标金后,计算总会款。
 * 第一版的总会款显示实际上是交接款，因为中标人不需要把钱交给自己。
 * 第二版可能会增加一个字段来区分总会款、交接款，因此注释里面保留了计算标准的总会款的代码。
 *
 * @param number        第几期, number-1就是当前的竞标结果在list中的index
 * @param totalNum      总期数
 * @param creatorId
 * @param biddingMethod 竞标规则
 * @param participants  所有参与的会脚
 * @param biddenMoney   标金
 * @param baseLineMoney
 * @param BidResult

 
 * @return
 */
+(int )caculateTotalMoneyWithnumber:(int )number AndtotalNum:(int )totalNum AndcreatorId:(int )creatorId  AndbiddingMethod:(NSString *)biddingMethod  AndParticipant:(NSArray *)participant AndBidResult:(NSArray *)BidResult  AndbiddenMoney:(int) biddenMoney AndbaseLineMoney:(int) baseLineMoney{
    int total = 0;
    int bidMethodValue =[biddingMethod intValue];
    
    for (int x = 0; x < BidResult.count; x ++) {
        resultBiddingObject *Obj =[BidResult objectAtIndex:x];
        NSLog(@"BidResult money:%@ andAll:%@ name:%@ andID:%@",Obj.biddenMoney,Obj.totalMoney,Obj.name,Obj.participantId);
    }
    for (int x = 0; x < participant.count; x ++) {
        NSDictionary *Obj =[participant objectAtIndex:x];
        NSLog(@"participant participantId:%@ andusednum:%@ andphone:%@",[Obj objectForKey:@"participantId"],[Obj objectForKey:@"totalNumber"],[Obj objectForKey:@"phoneNumber"]);
    }

    
    switch (bidMethodValue) {
        
        // 内标1：第1期算会头死，会头和会脚一样交钱，活的会脚为biddenMoney，死的会脚为baseLineMoney。
        case 0:
        for (NSDictionary *participantDic in participant) {
            int currentUsedNumber=  [self caculateCurrentUsedNumberWithnumber:number AndParticipant:participantDic AndBidResult:BidResult] ;
            resultBiddingObject *aBiddingResultObj =[BidResult objectAtIndex:number - 1];
            NSLog(@"currentUsedNumber:%d participantid:%@",currentUsedNumber,aBiddingResultObj.participantId);
            
            if ([[participantDic objectForKey:@"participantId"] isEqualToString:aBiddingResultObj.newparticipantId]) {
                // 如果是中标者，在这期不需要交钱
                total += 0;
            } else {
                // 未中标者按照死标、活标数交钱
                total += currentUsedNumber *baseLineMoney +([[participantDic objectForKey:@"totalNumber"] intValue] -currentUsedNumber)*biddenMoney ;
            }
            
        }
        break;
        
        // 内标2：第1期算会头死（且这个名额不参加第2到N-1期交钱），中间的每一期会头不交钱，最后1期把第1期的钱全部交出来
        case 1:
        {
            if (number ==1) {
                // 第1期同内标1，但实际上此处可以简化，可不按照内标1一样的计算方法来计算
                // 简化如下，可提供给最后一期计算用：第1期标金 = 会头钱；会头交的钱 = (会头总名数-1) * baseLineMoney；会脚交的钱 = (会脚的总名数) * baseLineMoney;
                for (NSDictionary *participantDic in participant) {
                    int currentUsedNumber=  [self caculateCurrentUsedNumberWithnumber:number AndParticipant:participantDic AndBidResult:BidResult];
                    resultBiddingObject *aBiddingResultObj =[BidResult objectAtIndex:number - 1];
                    
                    if ([[participantDic objectForKey:@"participantId"] isEqualToString:aBiddingResultObj.newparticipantId]) {
                        // 如果是中标者，在这期不需要交钱
                        total += 0;
                    } else {
                        // 未中标者按照死标、活标数交钱
                        total += currentUsedNumber *baseLineMoney +([[participantDic objectForKey:@"totalNumber"] intValue] -currentUsedNumber)*biddenMoney ;
                        
                    }
                    
                }
                
            } else if (number > 1 && number < totalNum) { // 第2到N-1期
                for (NSDictionary *participantDic in participant) {
                    int currentUsedNumber=  [self caculateCurrentUsedNumberWithnumber:number AndParticipant:participantDic AndBidResult:BidResult];
                    resultBiddingObject *aBiddingResultObj =[BidResult objectAtIndex:0];
                    
                    if ([[participantDic objectForKey:@"participantId"] intValue] == creatorId) {
                        // 会头
                        aBiddingResultObj =[BidResult objectAtIndex:number - 1];
                        if ([[participantDic objectForKey:@"participantId"] isEqualToString:aBiddingResultObj.newparticipantId]) {
                            // 同时又中标的话，那就不给钱了
                            total += 0;
                            //                                total += (p.getCurrentUsedNumber() - 1 - 1) * baseLineMoney + (p.getTotalNumber() - p.getCurrentUsedNumber()) * biddenMoney;
                        } else {
                            // 会头但没中标，少交一份会头钱
                            total += (currentUsedNumber -1)*baseLineMoney +([[participantDic objectForKey:@"totalNumber"] intValue] -currentUsedNumber)*biddenMoney ;
                        }
                    } else {
                        // 会脚
                        aBiddingResultObj =[BidResult objectAtIndex:number - 1];
                        if ([[participantDic objectForKey:@"participantId"] isEqualToString:aBiddingResultObj.newparticipantId]) {
                            // 中标，不交钱
                            total += 0;
                            //                                total += (p.getCurrentUsedNumber() - 1) * baseLineMoney + (p.getTotalNumber() - p.getCurrentUsedNumber()) * biddenMoney;
                        } else {
                            // 没有中标
                            total += currentUsedNumber *baseLineMoney +([[participantDic objectForKey:@"totalNumber"] intValue] -currentUsedNumber)*biddenMoney ;
                        }
                    }
                }
            } else if (number == totalNum) { // 第N期，实际上应该等于第1期的钱，这里不管如何编辑，结果应该一样
                for (NSDictionary *participantDic in participant) {
                    // 这里只有会头需要交钱
                    resultBiddingObject *aBiddingResultObj =[BidResult objectAtIndex:0];
                    if ([[participantDic objectForKey:@"participantId"]intValue] == creatorId) {
                        // 会头中标，那就不交钱
                        total += 0;
                        //                            total += (p.getTotalNumber() - 1) * baseLineMoney;
                    } else {
                        // 会脚中标，会头把第1期的钱全部交给他
                        total += [[participantDic objectForKey:@"totalNumber"] intValue] * baseLineMoney;
                    }
                }
            }
            break;
            
            // 内标3：第1期不算会头死，每一期会头和会脚一样交钱，活的会脚/会头都交biddenMoney，死的会头/会脚交baseLineMoney
            case 2:
            for (NSDictionary *participantDic in participant) {
                int currentUsedNumber=  [self caculateCurrentUsedNumberWithnumber:number AndParticipant:participantDic AndBidResult:BidResult];
                
                resultBiddingObject *aBiddingResultObj =[BidResult objectAtIndex:0];
                if ([[participantDic objectForKey:@"participantId"] intValue] ==creatorId) {
                    // 这里是与内标1唯一的区别，就是会头第1期不算死
                    currentUsedNumber = currentUsedNumber - 1;
                }
                // 这里回到和内标1一模一样
                aBiddingResultObj =[BidResult objectAtIndex:number - 1];
                if ([[participantDic objectForKey:@"participantId"] isEqualToString:aBiddingResultObj.newparticipantId]) {
                    // 如果是中标者，在这期不需要交钱
                    total += 0;
                } else {
                    // 未中标者按照死标、活标数交钱
                    total += currentUsedNumber *baseLineMoney +([[participantDic objectForKey:@"totalNumber"] intValue] -currentUsedNumber)*biddenMoney ;
                    
                }
                
            }
            break;
            
            // 外标：第1期算会头死或者活都一样，因为第1期的利息为0。
            case 3:
            for (NSDictionary *participantDic in participant) {
                int currentUsedNumber=  [self caculateCurrentUsedNumberWithnumber:number AndParticipant:participantDic AndBidResult:BidResult];
                
                resultBiddingObject *aBiddingResultObj =[BidResult objectAtIndex:number -1];
                if ([[participantDic objectForKey:@"participantId"] intValue]==creatorId ) {
                    currentUsedNumber = currentUsedNumber - 1;
                    // 会头
                    if ([[participantDic objectForKey:@"participantId"] isEqualToString:aBiddingResultObj.newparticipantId]) {
                        // 中标，不交钱
                        total += 0;
                    } else {
                        // 未中标，交钱。需要先计算从第2期累积到现在这一期为止，死标应该交出来的钱
                        int usedMoney = [self getUsedMoneyWithParticipant:participantDic AndbidResults:BidResult AndstartNum:2 AndendNum:number];
                        
                        total += usedMoney + ([[participantDic objectForKey:@"totalNumber"] intValue] - currentUsedNumber)*baseLineMoney;
                    }
                } else {
                    // 会脚
                    aBiddingResultObj =[BidResult objectAtIndex:number - 1];
                    if ([[participantDic objectForKey:@"participantId"] isEqualToString:aBiddingResultObj.newparticipantId]) {
                        // 中标，不交钱。
                        total += 0;
                    } else {
                        // 未中标，交钱。先计算从第1期累积到现在这一期为止，死标应该交出来的钱
                        int usedMoney = [self getUsedMoneyWithParticipant:participantDic AndbidResults:BidResult AndstartNum:1 AndendNum:number];
                        total += usedMoney + ([[participantDic objectForKey:@"totalNumber"] intValue] - currentUsedNumber)*baseLineMoney;
                    }
                }
                
            }
            
            break;
            
            default:
            break;
        }
    }
    return total;
}


/**
 * 外标计算使用到的方法
 * 计算某个人在两个周期内的死标金额累计值
 *
 * @param p
 * @param bidResults
 * @param startNum
 * @param endNum
 * @return
 */
+(int)getUsedMoneyWithParticipant:(NSDictionary *)participant AndbidResults:(NSArray *)bidResults AndstartNum:(int )startNum AndendNum:(int )endNum{
    
    int usedMoney = 0;
    
    for (int i = startNum - 1; i < endNum - 1; ++i) {
        resultBiddingObject *aBiddingResultObj =[bidResults objectAtIndex:i
                            ];
        if ([[participant objectForKey:@"participantId"] isEqualToString:aBiddingResultObj.newparticipantId]) {
            
            usedMoney += [aBiddingResultObj.biddenMoney intValue];
        }
    }
    return usedMoney;
    
}


//






@end
