
/** ======================================================
 *  
 *  PLEASE DON'T EDIT THIS FILE, JUST USE IT. 
 *  This file aims to provide a common use function. 
 */ 

#ifndef COMMON_CONFIG_H
#define COMMON_CONFIG_H

#import <UIKit/UIKit.h>

// -- Debug Support --
#pragma mark - Debug Support 
#ifdef DEBUG
#define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else 
#define DLog(...) do {  } while (0)
#endif

#define isMessageShow 0

// -- Language Support --
#pragma mark - Language Su34pport 

#define kLanguageDidChangeNotification @"GT_LanguageDidChangeNotification"

#define LANG_ZH @"tc"   // Tranditional Chinese
#define LANG_EN @"en"   // English
#define LANG_SC @"sc"   // Simplified Chinese

// Return application language.
NSString* appLanguage(void);

// Set application language.
void setAppLanguage(NSString *lang);

// Return YES if the appLanguage is Equal to <lang>
BOOL isAppLanguage(NSString *lang);

// Return YES if application is "Chinese"
BOOL isTraditionalChineseLocale( void );

// Return YES if application is "Simplified Chinese"
BOOL isSimplifiedChineseLocale( void );

// Return YES if application is "English"
BOOL isEnglishLocale( void );

// Return the translated string, based on the appLanguage.
NSString* localizedString(NSString* string);

// Return the app Lanuage,
NSString* apiAppLanguage(void);

//Return the Image by app language
UIImage *localizedImage(NSString *string);

//Return the imagename
NSString * localizedImageName(NSString * imageName);

// -- Functions -- 
#pragma mark - Fucntions
// Return the Document Directory Path
#define kDocumentDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// Return the Cache Directory Path
#define kCacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// For easy prompt Alert view
#define ALERT(title,msg,buttonTitle){UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil];[alert show];[alert release];}



NSString* trimString(NSString *string);
BOOL isEmptyString(NSString *string);

#define kError420 [[[NSError alloc] initWithDomain: @"serverConnectFail" code: 420 userInfo: nil] autorelease]
#define kError666 [[[NSError alloc] initWithDomain: @"Unknow Error." code: 666 userInfo: nil] autorelease]

#define kCacheDirectory [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kAPITimeOut 60.0f

#define isiPhone                ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

#pragma mark _____________ Fucntions    _____________

#define ALERT_PLUS(title,msg, cancelTitle){UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle: cancelTitle otherButtonTitles:nil];[alert show];[alert release];}

#define CHECKING_ALERT(title,msg){UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:localizedString(@"OK") otherButtonTitles:nil];[alert show];[alert release];}


/*
 *  NSUserDefaultKey
 */


/*
 * Notification
 */

#define kDBDownloadedNotification       @"DBDownloadedNotification"
#define kDBDownloadedDidFailNotification @"kDBDownloadedDidFailNotification"
#define kImageDownloadedNotification    @"ImageDownloadedNotification"
#define kUserDidLoginNotification       @"UserDidLoginNotification"
#define kUserDidLogoutNotification      @"UserDidLogoutNotification"
#define kCartRefreshNotification        @"CartRefreshNotification"

//Disneyland
#define  kReloginNotification           @"ReloginNotification"
//

//color code
#define kBlueColor      [UIColor colorWithRed:15/255.0f  green:71/255.0f  blue:130/255.0f alpha:1]
#define kGrayColor      [UIColor colorWithRed:0.3  green:0.3  blue:0.3 alpha:1]
#define kBrownColor     [UIColor colorWithRed:38/255.0f  green:21/255.0f  blue:4/255.0f alpha:1]


//HiddenTeammate
#define hiddenTeammateImageURLPrefix [NSString stringWithFormat: @"%@%@", kDomain, @"/dlh2012/images/hidden/"]

NSString * emptyStringIfNeed(NSString *string);

NSString *formattedNumber(double number, int dp);

NSString *validateMaxQuatity(NSString *inputText, int allowInput);

NSString *versionString();

BOOL checkEmail(NSString *email);

BOOL isIOS5Onwards(void);

//check network
BOOL connectedToNetwork(void);

//Dynamic Label Height
float calculateHeightOfText(NSString *text, UIFont *font, float width, UILineBreakMode lineBreakMode);
float calculateHeightOfLabel(UILabel *aLabel);


NSString *dateStrInCouponFormat(NSString *rawDateStr);
NSString *dateStrInNotificationFormat(NSString *rawDateStr);
NSString *dateStrInLuckyDrawFormat(NSString *rawDateStr);

#define IMAGE_TAG 999

@interface NSString (VersionChecking)
//Compare Version
-(BOOL) comapreVersionWithInternetVersion: (NSString *) inVersion;
@end

#endif