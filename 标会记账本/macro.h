#define EN_B [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]]

#define myCurrentBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[[NSLocale preferredLanguages] objectAtIndex:0] ofType:@"lproj"]]

#define currentLanguageBundle (nil == myCurrentBundle) ? EN_B : myCurrentBundle

#define LString(key) NSLocalizedStringFromTableInBundle(key, nil, currentLanguageBundle, @"")

#define alert(message) [[[UIAlertView alloc]initWithTitle:nil message:(message) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]

#define kAppFrameHeight [UIScreen mainScreen].applicationFrame.size.height
#define kAppFrameWidth [UIScreen mainScreen].applicationFrame.size.width

#define kDataExpiryTime 30
#define kAppLanguageIdChinese  0
#define kAppLanguageIdEnglish  1

//#define DEV_MAIN_SCREEN [[UIScreen mainScreen] bounds].size.height
#define DEV_MAIN_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define DEV_MAIN_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define Later_20_Mins   60*60*8

typedef enum
{
    Get_API_Tag_48 = 48,
    Get_API_Tag_65 = 65,
    Get_API_Tag_03 = 3,
    Get_API_Tag_06 = 6,
    Get_API_Tag_53 = 53,
    Get_API_Tag_54 = 54,
    Get_API_Tag_31 = 31,
    Get_API_Tag_32 = 32,
    Get_API_Tag_33 = 33,
    Get_API_Tag_12 = 12,
    Get_API_Tag_13 = 13,
    Get_API_Tag_22 = 22,
    Get_API_Tag_23 = 23,
        Get_API_Tag_40 = 40,
    Get_API_Tag_51_getNewsList = 51,
    Get_API_Tag_61_getNewsDetail = 61,
    Get_API_Tag_62 = 62,
    Get_API_Tag_53_add = 99,
    Get_API_Tag_53_remove =100,
    Get_API_Tag_18_resetPwd = 18,
    GET_API_Tag_70_portalConfig = 70,
    //Noah added
    GET_API_Tag_21_shop = 21,
    GET_API_Tag_210_shop_branchDistrict = 210,
    GET_API_Tag_71_appVersion = 71,
    GET_API_Tag_73 = 73,
}Get_Api_Tag;