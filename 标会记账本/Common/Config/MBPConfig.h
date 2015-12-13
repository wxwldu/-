//
//  MBPConfig.h
//  MembershipBonusPoint
//
//  Created by SSDIP0001 on 4/10/13.
//  Copyright (c) 2013 PCCW. All rights reserved.
//

#ifndef MBPCONFIG_H
#define MBPCONFIG_H


#import "AppDelegate.h"
// ---------------------------- MBP ----------------------------


#pragma mark - _____________ Environments _____________



#ifdef MORNINGSTAR
    #define MBPBaseURL @"https://mbp.pccws-essa.com/"
    #define MBPBaseShopURL @"https://common.pccws-essa.com/"
    #define currentIndustry @"msthk"
    #define kSharingWeChat 1
    #define kSharingFacebook 1
    #define kSharingWhatsApp 1
    #define kSharingWeChat_AppId @"wxc106a9fcf6e3c17d"
    #define kSharingDefaultUrl @"http://www.mst.com.hk"
//facebook app id: 623437241082255
//WeChat app id: wxc106a9fcf6e3c17d

#endif
#ifdef uat
    #define MBPBaseURL @"http://pccwmbp.no-ip.org/"
    #define MBPBaseShopURL @"http://pccwmbp.no-ip.org/"
    #define currentIndustry @"msthk" // @"eShop"  //@"msthk"
    #define kSharingWeChat 1
    #define kSharingFacebook 1
    #define kSharingWhatsApp 1
    #define kSharingWeChat_AppId @"wx15b9fb165a355cf2"
    #define kSharingDefaultUrl @"http://www.mst.com.hk"
//
//facebook app id: 570389936391728
//WeChat app id: wx15b9fb165a355cf2
#endif
// ---------------------------- PRODUCT PAGE SHARING SETTING ----------------------------


#define GoogleMapApi_key @"AIzaSyDvoJMaxR4NBlZusW1ThcfrkNWhobUUnS4"  //  Activated by:	pccwsolutionslimited@gmail.com 
#define UpdateURL @"itms-apps://itunes.apple.com/"

#define ShopListURL_EN @"http://pccwmbp.no-ip.org/mobile/morningstar/en/shop.html"
#define ShopListURL_CH @"http://pccwmbp.no-ip.org/mobile/morningstar/ch/shop.html"

#define MBPMorningStarHotline @"2519 8088"

#pragma mark - _____________ Enumerations _____________
enum {
    MBPActionSheetPlus = 0,
    MBPActionSheetMore,
} typedef MBPActionSheetTag;

enum {
    MBPNewCard = 0,
    MBPSignInCard,
    MBPSignedInCard,
} typedef MBPCardViewType;

enum {
    MyCardsGroup = 0,
    OtherCardsGroup,
} typedef MBPCardViewGroup;



#pragma mark - _____________ NSUserDefaults _____________
#define MBPFirstRequestTime @"firstRequestTime"
#define MBPNeedToGetAPI @"NeedToGetAPI"

#define MBPMerchantCardType @"MerchantCardTypeByIndustry"
#define MBPUserInfo @"MBPUserInfo"
#define MBPWalletDict @"MBPWalletDict"

//2013-11-05
#define MBPWalletInfo @"MBPWalletInfo"

#define MBPWishListData @"MBPWishListData"

#pragma mark - _____________ Animation Time _____________
#define MBPTransitionFlipDuration 0.5f


#define APP_DELEGATE                 (AppDelegate *)[[UIApplication sharedApplication] delegate]


#pragma mark - _____________ UI Elements _____________


//APP ID
#define ProjectAPPID  1067643742
 //1067643742


//#define MBPCardViewWidth 268.0f
//#define MBPCardViewHeight 326.0f

#define MBPVCNavBarMaxWidth 200.0f

#define MBPCardViewWidth 204.0f
#define MBPCardViewHeight 375.0f

#define MBPLargeCardViewWidth 255.0f
#define MBPLargeCardViewHeight 474.0f
#define MBPCardCarouselHeight 524.0f

//#define MBPProductDetailImageViewWidth  320.0f
//#define MBPProductDetailImageViewHeight 180.0f

#define MBPProductDetailImageViewWidth  320.0f//150.0f
#define MBPProductDetailImageViewHeight 320.0f//150.0f

#define PorjectGreenColor   [UIColor colorWithRed:56/255.0f  green:200/255.0f  blue:165/255.0f alpha:1]
#define MBPUISpaceX 10.0f
#define MBPUISpaceY 10.0f

#define MBPGreenColor     [UIColor colorWithRed:56/255.0f  green:200/255.0f  blue:165/255.0f alpha:1]
#define MBPLightGrayColorCopy     [UIColor colorWithRed:250/255.0f  green:250/255.0f  blue:255/255.0f alpha:1]
#define MBPLightGrayColorOne     [UIColor colorWithRed:231/255.0f  green:231/255.0f  blue:231/255.0f alpha:1]
#define MBPLightGrayColorTwo    [UIColor colorWithRed:80/255.0f  green:80/255.0f  blue:80/255.0f alpha:1]


#define MBPGreenColorCopy    [UIColor colorWithRed:87/255.0f  green:218/255.0f  blue:142/255.0f alpha:1]
#define MBPBlueColor     [UIColor colorWithRed:75/255.0f  green:128/255.0f  blue:217/255.0f alpha:1]
#define MBPRedColor      [UIColor colorWithRed:237/255.0f  green:2/255.0f  blue:36/255.0f alpha:1]
#define MBPGreenColorCopy    [UIColor colorWithRed:87/255.0f  green:218/255.0f  blue:142/255.0f alpha:1]

#define MBPOrangeColor    [UIColor colorWithRed:214/255.0f  green:90/255.0f  blue:50/255.0f alpha:1]
#define MBPLightBlue [UIColor colorWithRed:43/255.0f  green:82/255.0f  blue:150/255.0f alpha:1]
#define MBPDeepBlue  [UIColor colorWithRed:28/255.0f  green:55/255.0f  blue:104/255.0f alpha:1]
#define MBPMidGrayColor  [UIColor colorWithRed:154/255.0f  green:154/255.0f  blue:154/255.0f alpha:1]
#define MBPTiffinyGreenColor    [UIColor colorWithRed:78/255.0f  green:205/255.0f  blue:178/255.0f alpha:1]
#define MBPLightGrayColor  [UIColor colorWithRed:242/255.0f  green:242/255.0f  blue:242/255.0f alpha:1]

#define MBPLightPurpleColor  [UIColor colorWithRed:171/255.0f  green:127/255.0f  blue:212/255.0f alpha:1]

#define MBPDoneButtonGreen  [UIColor colorWithRed:133/255.0f  green:207/255.0f  blue:81/255.0f alpha:1]
#define MBPCancelButtonGrey  [UIColor colorWithRed:218/255.0f  green:222/255.0f  blue:220/255.0f alpha:1]


#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width


#define MBPLanguageId @"languageId"

#define MBPTabBarItemTitleOffset UIOffsetMake(0, -5)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) ? YES : NO
#define MBPCardFilterBarHeight 40.0f

#define MBPStatusBarHeight 20.0f

#define MBPCategoryListCellHeight 56

#define MBPVCTitleLabelRect  CGRectMake(100- (nameLabelWidth/2+14)+28, (50-22)/2, nameLabelWidth, 22)
#define MBPVCTitleImageRect  CGRectMake(100- (nameLabelWidth/2+14), (50-20)/2, 20, 20)

#pragma mark - _____________ UIFont _____________

#define MBPRobotoRegular22 [UIFont fontWithName:@"Roboto-Regular" size:22]
#define MBPRobotoRegular20 [UIFont fontWithName:@"Roboto-Regular" size:20]
#define MBPRobotoRegular16 [UIFont fontWithName:@"Roboto-Regular" size:16]
#define MBPRobotoRegular14 [UIFont fontWithName:@"Roboto-Regular" size:14]
#define MBPRobotoRegular12 [UIFont fontWithName:@"Roboto-Regular" size:12]
#define MBPRobotoRegular10 [UIFont fontWithName:@"Roboto-Regular" size:10]
#define MBPRobotoRegular24 [UIFont fontWithName:@"Roboto-Regular" size:24]

#define MBPNavBarTitleFont [UIFont fontWithName:@"Roboto-Light" size:21]
#define MBPSegmentedTitleFont [UIFont fontWithName:@"Roboto-Light" size:12]
#define MBPRobotoLight9 [UIFont fontWithName:@"Roboto-Light" size:9]
#define MBPRobotoLight12 [UIFont fontWithName:@"Roboto-Light" size:12]
#define MBPRobotoLight20 [UIFont fontWithName:@"Roboto-Light" size:20]
#define MBPRobotoLight24 [UIFont fontWithName:@"Roboto-Light" size:24]
#define MBPRobotoLight36 [UIFont fontWithName:@"Roboto-Light" size:36]

#define MBPRobotoMedium17 [UIFont fontWithName:@"Roboto-Medium" size:17]

#define MBPTabBarTitleFont [UIFont fontWithName:@"Roboto-Bold" size:8]
#define MBPRobotoBold7 [UIFont fontWithName:@"Roboto-Bold" size:7]
#define MBPRobotoBold8 [UIFont fontWithName:@"Roboto-Bold" size:8]
#define MBPRobotoBold10 [UIFont fontWithName:@"Roboto-Bold" size:10]
#define MBPRobotoBold12 [UIFont fontWithName:@"Roboto-Bold" size:12]
#define MBPRobotoBold14 [UIFont fontWithName:@"Roboto-Bold" size:14]
#define MBPRobotoBold15 [UIFont fontWithName:@"Roboto-Bold" size:15]
#define MBPRobotoBold16 [UIFont fontWithName:@"Roboto-Bold" size:16]
#define MBPRobotoBold18 [UIFont fontWithName:@"Roboto-Bold" size:18]


#define MBPFontColor909090  [UIColor colorWithRed:144/255.0f  green:144/255.0f  blue:144/255.0f alpha:1]
#define MBPFontColor202020  [UIColor colorWithRed:32/255.0f  green:32/255.0f  blue:32/255.0f alpha:1]
#define MBPFontColor101010  [UIColor colorWithRed:16/255.0f  green:16/255.0f  blue:16/255.0f alpha:1]
#define MBPFontColor3d3d3d  [UIColor colorWithRed:61/255.0f  green:61/255.0f  blue:61/255.0f alpha:1]
#define MBPFontColor5d5d5d  [UIColor colorWithRed:93/255.0f  green:93/255.0f  blue:93/255.0f alpha:1]
#define MBPFontColorb2b2b2  [UIColor colorWithRed:178/255.0f  green:178/255.0f  blue:178/255.0f alpha:1]
#define MBPFontColorffffff  [UIColor colorWithRed:255/255.0f  green:255/255.0f  blue:255/255.0f alpha:1]
#define MBPFontColora8a8a8  [UIColor colorWithRed:168/255.0f  green:168/255.0f  blue:168/255.0f alpha:1]
#define MBPFontColora808080  [UIColor colorWithRed:128/255.0f  green:128/255.0f  blue:128/255.0f alpha:1]
#define MBPFontColorabdbdbd  [UIColor colorWithRed:189/255.0f  green:189/255.0f  blue:189/255.0f alpha:1]
#define MBPFontColor000000  [UIColor colorWithRed:0/255.0f  green:0/255.0f  blue:0/255.0f   alpha:1]
#define MBPFontColorf87839  [UIColor colorWithRed:248/255.0f green:120/255.0f blue:57/255.0f alpha:1]
#define MBPFontColorE6E6E6  [UIColor colorWithRed:230/255.0f  green:230/255.0f  blue:230/255.0f alpha:1]

#define MBPFontColor5c9e2  [UIColor colorWithRed:92/255.0f  green:149/255.0f  blue:226/255.0f alpha:1]

#define MBPFontColor5c9e2Darken  [UIColor colorWithRed:62/255.0f  green:119/255.0f  blue:196/255.0f alpha:1]
#define MBPUserDidChangeCardNotificationKey @"MBPUserDidChangeCardNotificationKey"

#endif