
#import "Common-Config.h"
#import "Reachability.h"

/** ======================================================
 *  
 *  PLEASE DON'T EDIT THIS FILE, JUST USE IT. 
 *
 */ 

NSString* const kLanguageSelected = @"kLanguageSelected";

BOOL checkEmail(NSString *email){
	NSString* emailRegEx = [NSString stringWithContentsOfFile: [[[NSBundle mainBundle] resourcePath]
																stringByAppendingPathComponent: @"emailReg.txt"]
													 encoding: NSASCIIStringEncoding error: nil];
	NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	BOOL emailRegExResult = [emailPredicate evaluateWithObject: email];
	
	if (!emailRegExResult || email.length < 1)
		return NO;
    
	return YES;
}

NSString* appLanguage(void) {
    NSString *appLang = [[NSUserDefaults standardUserDefaults] objectForKey: kLanguageSelected];
    
    if (appLang){
        return appLang;
    }
    else{
        return [[NSUserDefaults standardUserDefaults] objectForKey: kLanguageSelected];
    }
}

void setAppLanguage(NSString *lang) {
    
    [[NSUserDefaults standardUserDefaults] setObject: lang forKey: kLanguageSelected];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLanguageDidChangeNotification object:nil];
}

BOOL isAppLanguage(NSString *lang) {
    return [appLanguage() isEqualToString:lang];
}

// Return YES if application is "Chinese"
BOOL isTraditionalChineseLocale(){
    return [appLanguage() isEqualToString:LANG_ZH];
}

// Return YES if application is "Simplified Chinese"
BOOL isSimplifiedChineseLocale(){
    return [appLanguage() isEqualToString:LANG_SC];
}

// Return YES if application is "English"
BOOL isEnglishLocale(){
    return (appLanguage() == nil || [appLanguage() isEqualToString:LANG_EN]);
}

NSString* localizedString(NSString* string) {
    return NSLocalizedStringFromTable(string, appLanguage(), @"");
}

NSString* trimString(NSString *string) {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
BOOL isEmptyString(NSString *string) {
    return [trimString(string) length] == 0;
}

#pragma mark - network checking
BOOL connectedToNetwork()
{
    Reachability* reachability = [Reachability reachabilityForInternetConnection];
    
    return ([reachability currentReachabilityStatus] != NotReachable);
    
//    // Create zero addy
//    struct sockaddr_in zeroAddress;
//    bzero(&zeroAddress, sizeof(zeroAddress));
//    zeroAddress.sin_len = sizeof(zeroAddress);
//    zeroAddress.sin_family = AF_INET;
//    
//    // Recover reachability flags
//    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
//    SCNetworkReachabilityFlags flags;
//    
//    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//    CFRelease(defaultRouteReachability);
//    
//    if (!didRetrieveFlags)
//    {
//        printf("Error. Could not recover network reachability flags\n");
//        return NO;
//    }
//    
//    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
//    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
//    return (isReachable && !needsConnection) ? YES : NO;
}


// Return the app Language,
NSString* apiAppLanguage(void){
    if (isAppLanguage(LANG_EN)){ //En
        return @"en";
    }
    else if (isAppLanguage(LANG_ZH)){
        return @"tc";
    }else if (isAppLanguage(LANG_SC)){
        return @"sc";
    }
    return @"en";
}

//Return the Image by app language
UIImage *localizedImage(NSString *string){
    return [UIImage imageNamed:[NSString stringWithFormat:string,appLanguage()]];
}

NSString * localizedImageName(NSString * imageName)
{
    if (isAppLanguage(LANG_EN)) {
        return [NSString stringWithFormat:@"%@_en.png", imageName];
    }
    else if (isAppLanguage(LANG_ZH)) {
        return [NSString stringWithFormat:@"%@_tc.png", imageName];
    }
    else if (isAppLanguage(LANG_SC)){
        return [NSString stringWithFormat:@"%@_sc.png", imageName];
    }
    return nil;
}

////Dynamic Label Height
//float calculateHeightOfText(NSString *text, UIFont *font, float width, UILineBreakMode lineBreakMode)
//{
//    CGSize suggestedSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, FLT_MAX) lineBreakMode:lineBreakMode];
//    
//    return suggestedSize.height;
//}

float calculateHeightOfLabel(UILabel *aLabel)
{
    CGSize suggestedSize = [aLabel.text sizeWithFont:aLabel.font constrainedToSize:CGSizeMake(aLabel.frame.size.width, FLT_MAX) lineBreakMode:aLabel.lineBreakMode];
    
    return suggestedSize.height+20;
}

//2012-11-27
NSString *dateStrInCouponFormat(NSString *rawDateStr)
{
    NSString *aStr = @"";
    
    if(rawDateStr)
    {
        NSArray *anArray = [rawDateStr componentsSeparatedByString:@" "];
        
        if(anArray && [anArray count] >= 1)
        {
            NSString *aDateStr = [anArray objectAtIndex:0];
            
            if(aDateStr)
            {
                NSArray *anArray02 = [aDateStr componentsSeparatedByString:@"-"];
                
                if(anArray02 && [anArray02 count] == 3)
                {
                    NSString *day = [anArray02 objectAtIndex:2];
                    NSString *month = [anArray02 objectAtIndex:1];
                    NSString *year = [anArray02 objectAtIndex:0];
                    
                    aStr = [NSString stringWithFormat:@"%@/%@/%@",day,month,year];
                }
            }
        }
    }
    
    return aStr;
}

NSString *dateStrInNotificationFormat(NSString *rawDateStr)
{
    NSString *aStr = @"";
    
    if(rawDateStr)
    {
        NSArray *anArray = [rawDateStr componentsSeparatedByString:@" "];
        
        if(anArray && [anArray count] >= 1)
        {
            NSString *aDateStr = [anArray objectAtIndex:0];
            
            if(aDateStr)
            {
                NSArray *anArray02 = [aDateStr componentsSeparatedByString:@"-"];
                
                if(anArray02 && [anArray02 count] == 3)
                {
                    NSString *day = [anArray02 objectAtIndex:2];
                    NSString *month = [anArray02 objectAtIndex:1];
                    NSString *year = [anArray02 objectAtIndex:0];
                    
                    aStr = [NSString stringWithFormat:@"%@-%@-%@",day,month,year];
                }
            }
        }
    }
    
    return aStr;
}

//2012-12-03
NSString *dateStrInLuckyDrawFormat(NSString *rawDateStr)
{
    NSString *aStr = @"";
    
    if(rawDateStr)
    {
        NSArray *anArray = [rawDateStr componentsSeparatedByString:@" "];
        
        if(anArray && [anArray count] >= 1)
        {
            NSString *aDateStr = [anArray objectAtIndex:0];
            
            if(aDateStr)
            {
                NSArray *anArray02 = [aDateStr componentsSeparatedByString:@"-"];
                
                if(anArray02 && [anArray02 count] == 3)
                {
                    NSString *day = [anArray02 objectAtIndex:2];
                    NSString *month = [anArray02 objectAtIndex:1];
//                    NSString *year = [anArray02 objectAtIndex:0];
                    
                    aStr = [NSString stringWithFormat:@"%@/%@",day,month];
                }
            }
        }
    }
    
    return aStr;
}

@implementation NSString (VersionChecking)

//Compare Version
-(BOOL) comapreVersionWithInternetVersion: (NSString *) inVersion{
	
	/**
	 **		Assume that the version is in    x.y.z   format.
	 **/
	
	BOOL needUpdate = NO;
    
	//Check if the inversion is larger.
	
	NSArray *inVersionArray = [inVersion componentsSeparatedByString: @"."];
	NSArray *localVersionArray = [self componentsSeparatedByString: @"."];
	
    
	int inVal = 0;
	int localVal = 0;
	
	for (int i = 0; i < 3; i++){
        //reset the value...
        inVal = -1;
        localVal = -1;
        //
        
		if ([inVersionArray count] > i){
			inVal = [[inVersionArray objectAtIndex: i] intValue];
		}
        //		else {
        //			break;
        //		}
        
        
		if ([localVersionArray  count] > i){
			localVal = [[localVersionArray objectAtIndex: i] intValue];
		}
        //		else {
        //			break;
        //		}
        
		
		if (inVal > localVal){
			needUpdate = YES;
			break;
		}
		else {
			if (inVal < localVal){
				break;
			}
		}
	}
	
	return needUpdate;
}

@end