//
//  GeneralHelper.h
//  SCA
//
//  Created by kyTang on 21/04/2016.
//  Copyright © 2016 ADS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@import Firebase;


@interface GeneralHelper : NSObject


+(AppDelegate *)appDelegate;
+(FIRDatabaseReference *)firDatabaseRef;

+ (BOOL) isDeviceiPhone4;
+ (BOOL) isDeviceiPhone5;
+ (BOOL) isDeviceiPhone6;
+ (BOOL) isDeviceiPhone6plus;

+ (BOOL)hasConnection;

+ (NSString *) getCurrentDateTime;

+ (UIImage *)generateThumbImage : (NSURL *)videoURL;

+(BOOL)emailValidator:(NSString *)aCheckString;
+(BOOL)phoneNumberValidator:(NSString *)aCheckString;

+(void)initTabBarController:(UITabBarController *)tabBarController;

+(void)addProgressHud:(UIView *)view;
+(void)removeProgressHud;

+(UIColor *)colorWithHexString:(NSString *)hexString;
+(UIImage *)takeScreenshot:(UIView *)view;

+(NSData *)compressImage:(UIImage *)image;
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+(NSString *)formattedNumber:(int)number;
+(NSString *)formattedFloatNumber:(float)number;

+ (NSString *)timestampToDate:(double)timestamp;
+ (NSTimeInterval)dateToTimeStamp: (NSString*)date;

+(NSString *)hash:(NSString *)aInput;

+(CGFloat)heightForText:(NSString*)text withFont:(UIFont *)font andWidth:(CGFloat)width;


@end
