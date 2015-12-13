#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIColor (ColorWithHex)
// Convert hexadecimal value to RGB
+ (UIColor *)colorWithHex:(UInt32)hexadecimal;
+ (UIColor *)colorWithHexString:(NSString *)hexadecimal;

// Convert hexadecimal value to RGB
// format:
//	0x = Hexadecimal specifier (# for strings)
//	ff = alpha, ff = red, ff = green, ff = blue
+ (UIColor *)colorWithAlphaHex:(UInt32)hexadecimal;
+ (UIColor *)colorWithAlphaHexString:(NSString *)hexadecimal;

// Return the hexadecimal value of the RGB color specified.
+ (NSString *)hexStringFromColor:(UIColor *)color;
+ (NSString *)hexStringFromColor:(UIColor *)color hash:(BOOL)withHash;
+ (NSString *)hexStringWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

// Generates a color randomly
+ (UIColor *)randomColor;

@end
