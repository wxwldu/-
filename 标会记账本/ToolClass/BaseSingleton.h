//
//  BaseSingleton.h
//  MembershipBonusPoint
//
//  Created by Anna on 13-7-30.
//  Copyright (c) 2013年 PCCW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BaseSingleton : NSObject
{
    int currentUseCardId;
}
@property (nonatomic, assign) int currentUseCardId;
@property (nonatomic, strong) NSMutableArray *myCardArr;
@property (nonatomic, strong) NSMutableArray *merchantCardArr;
@property (nonatomic, assign) int productKey;
@property (nonatomic) int floorCount;
@property (nonatomic, strong) NSMutableArray *tableHeadTitleArray;
@property (nonatomic, strong) NSString *firstLevelTitle;
@property (nonatomic, strong) NSString *secondLevelTitle;

@property (nonatomic, assign) int parentCategoryId;

@property (nonatomic, strong) NSDictionary *productCategoryInfo;
@property (nonatomic, strong) NSMutableArray *cardsLognIn;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *membershipId;
@property (nonatomic, retain) NSDictionary *productDetail;
@property (nonatomic, strong) NSMutableArray *cardLoginArr;
@property (nonatomic, strong) NSMutableArray *cardsProtalConfigArray;
@property (nonatomic, strong) NSMutableArray *updateMemberWalletInfo;
@property (nonatomic, strong) NSDictionary *addToMyCartProduct;
@property (nonatomic) int termOfPaymentTag;

@property (nonatomic) int  selectMerchantId;
@property (nonatomic) BOOL selectCard;


+(BaseSingleton*)shareSigleton;

@end
