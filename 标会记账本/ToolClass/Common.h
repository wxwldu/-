//
//  Common.h
//  MembershipBonusPoint
//
//  Created by Anna on 13-8-9.
//  Copyright (c) 2013年 PCCW. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommonDelegate;

@interface Common : NSObject
{
    id<CommonDelegate>      delegate;
    NSURL                   *baseUrl;
    NSString                *path;
    NSMutableURLRequest     *request;
}

@property (nonatomic, strong) id<CommonDelegate>      delegate;
@property (nonatomic, strong) NSURL                   *baseUrl;
@property (nonatomic, strong) NSString                *path;
@property (nonatomic, strong) NSMutableURLRequest     *request;

- (void) login_Api03_WithMerchantId:(int)           _merchantId
                           andEmail:(NSString *)    _email
                             andPwd:(NSString *)    _password
                            success:(void (^)(NSDictionary *dict))success
                            failure:(void (^)(NSError *error))failure;

- (void) genarateNewPassword_Api06_withMerchantId:(int)_merchantId
                                         andEmail:(NSString *)_email
                                          success:(void (^)(NSDictionary *dict))success
                                          failure:(void (^)(NSError *error))failure;



//Get wish List
- (void) getApi12GetWishListWithMerchanId:(NSString *)_merchantId
                              andMemberId:(NSString *)_memberId
                          andMembershipId:(NSString *)_membershipId
                                  success:(void (^)(NSDictionary *dict))success
                                  failure:(void (^)(NSError *error))failure;
//- (void) getApi12GetWishListWithMerchanId:(NSString *)_merchantId
//                              andMemberId:(NSString *)_memberId
//                          andMembershipId:(NSString *)_membershipId;
/**
 action:add OR remove
 **/
- (void) getApi13UpdateWishListWithMerchantId:(NSString *)_merchantId
                                  andMemberId:(NSString *)_memberId
                                     andToken:(NSString *)_token
                              andMembershipId:(NSString *)_membershipId
                                 andProductId:(NSString *)_productId
                                    andAction:(NSString *)_action
                                      success:(void (^)(NSDictionary *dict))success
                                      failure:(void (^)(NSError *error))failure;



#pragma mark - resetPwd
//API 18 reset password
- (void)resetPassword_Api18_WithMerchantId:(NSString *)_merchantId
                               andMemberId:(NSString *)_memberId
                             andcurrentPwd:(NSString *)_currentPwd
                                 andNewPwd:(NSString *)_newPwd
                                andSendPwd:(NSString *)_sendPwd
                                  andToken:(NSString *)_token
                                   success:(void (^)(NSDictionary *dict))success
                                   failure:(void (^)(NSError *error))failure;

//Noah added
#pragma mark - get branches by districtId

- (void)getBranchesByDistrictId_Api46_withMerchantId:(NSString *)_merchantId
                                       andLanguageId:(NSString *)_languageId
                                             success:(void (^)(NSDictionary *dict))success
                                             failure:(void (^)(NSError *error))failure;
#pragma mark - get branch district

- (void)getBranchDistrict_Api45_withMerchantId:(NSString *)_merchantId
                                 andLanguageId:(NSString *)_languageId
                                       success:(void (^)(NSDictionary *dict))success
                                       failure:(void (^)(NSError *error))failure;


//get wish List


- (void) getApi22UpdateCurrentLocationOfMemberWithMerchantId:(NSString *)_merchantId
                                                 andMemberId:(NSString *)_memberId
                                                     andGeoX:(double)    _x
                                                     andGeoY:(double)    _y
                                                     success:(void (^)(NSDictionary *dict))success
                                                     failure:(void (^)(NSError *error))failure;

- (void)getApi23UpdateMemberDeviceWithMerchantId:(NSString *)_merchantId
                                     andMemberId:(NSString *)_memberId
                                       andAction:(NSString *)_action
                                         success:(void (^)(NSDictionary *dict))success
                                         failure:(void (^)(NSError *error))failure;


//API 31 get Product Category
- (void)getAPI31ProductCategoryWithMerchantId:(NSString *)_merchantId
                                andLanguageId:(NSString *)_languageId
                          andParentCategoryId:(NSString *)_parentCategoryId
                                     andLevel:(NSString *)_level
                                      success:(void (^)(NSDictionary *dict))success
                                      failure:(void (^)(NSError *error))failure;


- (void) get_Api32_GetProductWithMerchantId:(NSString *)_merchantId
                              andLanguageId:(NSString *)_languageId
                              andCategoryId:(NSString *)_categoryId
                               andSort_type:(NSString *)_sort_type
                                andSort_seq:(NSString *)_sort_seq
                                  andOffset:(int)_offset
                                    andHits:(int)_hits
                                    success:(void (^)(NSDictionary *dict))success
                                    failure:(void (^)(NSError *error))failure;



//API 33 get Product By id
- (void)getAPI33ProductById:(NSString *)_productId
              andLanguageId:(NSString *)_languageId
                andMemberId:(NSString *)_memberId
            andMembershipId:(NSString *)_membershipID
                    success:(void (^)(NSDictionary *dict))success
                    failure:(void (^)(NSError *error))failure;



//API 40 get member coupon
- (void)getAPI40GetMemerberCouponWithBymerchantId:(NSString *)_merchantId
                                      andMemberId:(NSString *)_memberId
                                    andLanguageId:(NSString *)_languageId
                                  andMembershipId:(NSString *)_membershipId
                                     andSort_type:(NSString *)_sort_type
                                andLatestOrExpire:(NSString *)_LatestOrExpire
                                      andSort_seq:(NSString *)_sort_seq
                                        andOffset:(NSString *)_offset
                                          andHits:(NSString *)_hits;


- (void) updateMBPWallet_Api53_WithMBPid:(NSString *)         _mbpId
                           andMerchantId:(int)                _merchantId
                             andMemberId:(int)                _memberId
                             andCardType:(NSString *)         _type
                               andAction:(NSString *)         _action
                                andToken:(NSString *)         _token
                                 success:(void (^)(NSDictionary *dict))success
                                 failure:(void (^)(NSError *error))failure;


- (void) getMBPWallet_Api54_WithMerchantId:(int)           _merchantId
                               andMemberId:(int)           _memberId
                               andCardType:(NSString *)    _cardType
                                  andToken:(NSString *)    _token
                                   success:(void (^)(NSDictionary *dict))success
                                   failure:(void (^)(NSError *error))failure;

- (void) GetMerchantCardType_API48;

- (void) getPortalConfig_Api65_WithLanguageId:(int)           _languageId
                                andMerchantId:(int)    _merchantId
                                    success:(void (^)(NSDictionary *dict))success
                                    failure:(void (^)(NSError *error))failure;





//API 62 get memeber coupon by code
- (void)getAPI62GetMemerberCouponByCodeWithBymerchantId:(NSString *)_merchantId
                                            andMemberId:(NSString *)_memberId
                                          andLanguageId:(NSString *)_languageId
                                        andMembershipId:(NSString *)_membershipId
                                          andCouponCode:(NSString *)_couponCode;
//API 51 and API 61
#pragma mark -
#pragma mark - News
- (void)getNewsList_Api51_WithMerchantId:(NSString *)_merchantId
                           andLanguageId:(NSString *)_languageId;

- (void)getNewsDetai_Api61_lWithMerchantId:(NSString *)_merchantId
                             andLanguageId:(NSString *)_languageId
                                 andNewsId:(NSString *)_newsId;




#pragma mark - get portal config by industry
- (void)getPortalConfig_Api70_withIndustry:(NSString *)_industry
                             andLanguageId:(NSString *)_languageId;


//Noah added
#pragma mark -
#pragma mark - FRS 71 Check app version - API 71
- (void)checkAppVersion_Api71_withCurrentOS:(NSString *)_os
                          andCurrentVersion:(NSString *)_version
                                    success:(void (^)(NSDictionary *dict))success
                                    failure:(void (^)(NSError *error))failure;


#pragma mark - Get Travel Info - API 73
- (void) getAPI73TravelInfoWithMerchantId:(NSString*)_merchantId
                            andLanguageId:(NSString *)_languageId
                                  success:(void (^)(NSDictionary *dict))success
                                  failure:(void (^)(NSError *error))failure;

@end
@protocol CommonDelegate <NSObject>

-(void)getApiResultSucces:(NSDictionary *)result andApiTag:(int)tag;
-(void)getApiResultFailed:(NSError *)error;

@end