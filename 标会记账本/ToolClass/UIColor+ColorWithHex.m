#import "UIColor+ColorWithHex.h"

@implementation UIColor (ColorWithHex)

#pragma mark - Category Methods
// Direct Conversion to hexadecimal (Automatic)
+ (UIColor *)colorWithHex:(UInt32)hexadecimal
{
	CGFloat red, green, blue;
	
	// bitwise AND operation
	// hexadecimal's first 2 values
	red = ( hexadecimal >> 16 ) & 0xFF;
	// hexadecimal's 2 middle values
	green = ( hexadecimal >> 8 ) & 0xFF;
	// hexadecimal's last 2 values
	blue = hexadecimal & 0xFF;
	
	UIColor *color = [UIColor colorWithRed: red / 255.0f green: green / 255.0f blue: blue / 255.0f alpha: 1.0f];
	return color;
}

+ (UIColor *)colorWithAlphaHex:(UInt32)hexadecimal
{
	CGFloat red, green, blue, alpha;
	
	// bitwise AND operation
	// hexadecimal's first 2 values
	alpha = ( hexadecimal >> 24 ) & 0xFF;
	// hexadecimal's third and fourth values
	red = ( hexadecimal >> 16 ) & 0xFF;
	// hexadecimal's fifth and sixth values
	green = ( hexadecimal >> 8 ) & 0xFF;
	// hexadecimal's seventh and eighth
	blue = hexadecimal & 0xFF;
	
	UIColor *color = [UIColor colorWithRed: red / 255.0f green: green / 255.0f blue: blue / 255.0f alpha: alpha / 255.0f];
    return color;
}

+ (UIColor *)colorWithHexString:(NSString *)hexadecimal
{
	// convert Objective-C NSString to C string
	const char *cString = [hexadecimal cStringUsingEncoding: NSASCIIStringEncoding];
	long int hex;
	
	// if the string contains hash tag (#) then remove
	// hash tag and convert the C string to a base-16 int
	if ( cString[0] == '#' ) {
		hex = strtol(cString + 1, NULL, 16);
	}
	else {
		hex = strtol(cString, NULL, 16);
	}
	
	UIColor *color = [self colorWithHex: hex];
	return color;
}

+ (UIColor *)colorWithAlphaHexString:(NSString *)hexadecimal
{
	const char *cString = [hexadecimal cStringUsingEncoding: NSASCIIStringEncoding];
	long long int hex;
	
	if ( cString[0] == '#' ) {
		hex = strtoll( cString + 1 , NULL , 16 );
	}
	else {
		hex = strtoll( cString , NULL , 16 );
	}
	
	UIColor *color = [self colorWithAlphaHex: hex];
	return color;
}

// deprecated: Use 'hexStringFromColor:' instead.
+ (NSString *)colorWithRGBToHex:(UIColor *)color
{
	// Get the color components of the color
	const CGFloat *components = CGColorGetComponents( [color CGColor] );
	// Multiply it by 255 and display the result using an uppercase hexadecimal specifier (%X) with a character length of 2
	NSString *hexadecimal = [NSString stringWithFormat: @"#%02X%02X%02X" , (int)(255 * components[0]) , (int)(255 * components[1]) , (int)(255 * components[2])];
	
	return hexadecimal;
}
// deprecated

+ (NSString *)hexStringFromColor:(UIColor *)color
{
	NSString *string = [self hexStringFromColor: color hash: YES];
	return string;
}

+ (NSString *)hexStringFromColor:(UIColor *)color hash:(BOOL)withHash
{
	// get the color components of the color
	const NSUInteger totalComponents = CGColorGetNumberOfComponents( [color CGColor] );
	const CGFloat *components = CGColorGetComponents( [color CGColor] );
	NSString *hexadecimal = nil;
	
	// some cases, totalComponents will only have 2 components
	// such as black, white, gray, etc..
	// multiply it by 255 and display the result using an uppercase
	// hexadecimal specifier (%X) with a character length of 2
	switch ( totalComponents ) {
		case 4 :
			hexadecimal = [NSString stringWithFormat: @"#%02X%02X%02X" , (int)(255 * components[0]) , (int)(255 * components[1]) , (int)(255 * components[2])];
			break;
			
		case 2 :
			hexadecimal = [NSString stringWithFormat: @"#%02X%02X%02X" , (int)(255 * components[0]) , (int)(255 * components[0]) , (int)(255 * components[0])];
			break;
			
		default:
			break;
	}
	
	return hexadecimal;
}

+ (NSString *)hexStringWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
	UIColor *color = [UIColor colorWithRed: red green: green blue: blue alpha: 1.0f];
	NSString *string = [self hexStringFromColor: color];
	return string;
}

+ (UIColor *)randomColor
{
	static BOOL generated = NO;
	
	// ff the randomColor hasn't been generated yet,
	// reset the time to generate another sequence
	if ( !generated ) {
		generated = YES;
		srandom( time( NULL ) );
	}
	
	// generate a random number and divide it using the
	// maximum possible number random() can be generated
	CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
	
	UIColor *color = [UIColor colorWithRed: red green: green blue: blue alpha: 1.0f];
	return color;
}
@end
