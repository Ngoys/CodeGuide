//
//  GeneralHelper.m
//  SCA
//
//  Created by kyTang on 21/04/2016.
//  Copyright © 2016 ADS. All rights reserved.
//

#import "GeneralHelper.h"
#import "Reachability.h"
#import <AVFoundation/AVFoundation.h>
#import "JHUD.h"
#import "Constants.h"
#import <CommonCrypto/CommonCrypto.h>
#import "User.h"
@import Firebase;

@implementation GeneralHelper

+(AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
+(FIRDatabaseReference *)firDatabaseRef {
    
    return [[FIRDatabase database] referenceFromURL: FIREBASE_DATABASE_REF];
}
+(UIImage *) takeScreenshot:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    NSData * data = UIImagePNGRepresentation(image);
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    
    return [UIImage imageWithData:data];
}

#pragma mark - Devices Screens Resolution

+ (BOOL) isDeviceiPhone4
{
    if ((int)[[UIScreen mainScreen] bounds].size.height == 480)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isDeviceiPhone5
{
    if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isDeviceiPhone6
{
    if ((int)[[UIScreen mainScreen] bounds].size.height == 667)
    {
        return YES;
    }
    return NO;
}

+ (BOOL) isDeviceiPhone6plus
{
    if ((int)[[UIScreen mainScreen] bounds].size.height == 736)
    {
        return YES;
    }
    return NO;
}

#pragma mark - Internet Connection Checking
+ (BOOL) hasConnection
{
    if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        return false;
    }
    return true;
}

#pragma mark - DateTime 
+ (NSString *) getCurrentDateTime {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm a"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

#pragma mark - Video
+ (UIImage *)generateThumbImage : (NSURL *)videoURL
{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL: videoURL options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    NSError *err = NULL;
    CMTime requestedTime = CMTimeMake(1, 60);     // To create thumbnail image
    CGImageRef imgRef = [generator copyCGImageAtTime:requestedTime actualTime:NULL error:&err];
    NSLog(@"err = %@, imageRef = %@", err, imgRef);
    
    UIImage *thumbnailImage = [[UIImage alloc] initWithCGImage:imgRef];
    CGImageRelease(imgRef);    // MUST release explicitly to avoid memory leak
    
    return thumbnailImage;

}

#pragma mark - UIColor
+ (UIColor *)colorWithHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

#pragma mark - UIImage
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
+(NSData *)compressImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 1280;
    float maxWidth = 1280;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.50;//5% compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth){
        if(imgRatio < maxRatio){
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio){
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else{
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *jpegData = UIImageJPEGRepresentation(img, compressionQuality);
    return jpegData;
}
#pragma mark - TabBarController

+(void)initTabBarController:(UITabBarController *)tabBarController {
    
    tabBarController.delegate = self;
    [tabBarController.tabBar.layer setBackgroundColor:[[UIColor whiteColor] CGColor]];
    tabBarController.tabBar.layer.shadowColor = [[UIColor grayColor] CGColor];
    tabBarController.tabBar.layer.masksToBounds = NO;
    tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, -5);
    tabBarController.tabBar.layer.shadowRadius = 5;
    tabBarController.tabBar.layer.shadowOpacity = 0.3;
    [tabBarController.tabBar setTintColor:[UIColor clearColor]];
    
    
    NSMutableArray *tbViewControllers = [NSMutableArray arrayWithArray:[tabBarController viewControllers]];
    User *_user = [User getUserInfo];
    
    [tabBarController setViewControllers:tbViewControllers];
    
    
    UITabBarItem *tabBarItem0 = [tabBarController.tabBar.items objectAtIndex:0];
    [tabBarItem0 setTitle:@"Tutorial"];
    [tabBarItem0 setImage:[[GeneralHelper imageWithImage:[UIImage imageNamed:@"tutorial_white"] scaledToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem0 setSelectedImage:[[GeneralHelper imageWithImage:[UIImage imageNamed:@"tutorial_red"] scaledToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    UITabBarItem *tabBarItem1 = [tabBarController.tabBar.items objectAtIndex:1];
    [tabBarItem1 setImage:[[GeneralHelper imageWithImage:[UIImage imageNamed:@"camera_white"] scaledToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem1 setSelectedImage:[[GeneralHelper imageWithImage:[UIImage imageNamed:@"camera_red"] scaledToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem1 setTitle:@"Camera"];
    
    
    UITabBarItem *tabBarItem2 = [tabBarController.tabBar.items objectAtIndex:2];
    [tabBarItem2 setImage:[[GeneralHelper imageWithImage:[UIImage imageNamed:@"profile_notselected"] scaledToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem2 setSelectedImage:[[GeneralHelper imageWithImage:[UIImage imageNamed:@"profile_selected"] scaledToSize:CGSizeMake(30, 30)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem2 setTitle:@"Profile"];
    
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }
                                             forState:UIControlStateSelected];

}

#pragma mark - ProgressHud
+(void)addProgressHud:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        JHUD *_hudview = [[JHUD alloc]initWithFrame:view.bounds];
        _hudview.tag = 9999;
        [_hudview setBackgroundColor:[UIColor clearColor]];
        _hudview.messageLabel.text = @"Loading...";
        NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"spinner.gif" ofType:nil]];
        NSData *imageData = [NSData dataWithContentsOfURL:fileURL];
        [_hudview setGifImageData:imageData];
        
        //show
        [_hudview showAtView:view hudType:JHUDLoadingTypeGifImage];

        [GeneralHelper appDelegate].window.userInteractionEnabled = YES;
        _hudview.userInteractionEnabled = YES;
    });
}

+(void)removeProgressHud
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        JHUD *removeView;
        
        while((removeView = [[GeneralHelper appDelegate].window viewWithTag:9999]) != nil) {
            
            [removeView removeFromSuperview];
            [removeView hide];
            removeView = nil;
        }
    });
}

#pragma mark - Validator
+(BOOL)emailValidator:(NSString *)aCheckString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:aCheckString];
}
+(BOOL)phoneNumberValidator:(NSString *)aCheckString
{
    NSString *laxString = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", laxString];
    return [emailTest evaluateWithObject:aCheckString];
}

#pragma mark - Formatter
+ (NSString *)formattedNumber:(int)number
{
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setNumberStyle:NSNumberFormatterDecimalStyle];
    [fmt setMaximumFractionDigits:0];
    return [fmt stringFromNumber:@(number)];
}

+ (NSString *)formattedFloatNumber:(float)number
{
    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setNumberStyle:NSNumberFormatterDecimalStyle];
    [fmt setMaximumFractionDigits:0];
    return [fmt stringFromNumber:@(number)];
}
+ (NSString *)timestampToDate:(double)timestamp
{
    double unixTimeStamp = timestamp;
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *_date = [_formatter stringFromDate:date];
    
    return _date;
}

+ (NSTimeInterval)dateToTimeStamp: (NSString*)date {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *nsdate = [dateFormat dateFromString:date];
    NSTimeInterval ti = [nsdate timeIntervalSince1970];
    return ti;
}

+(NSString *)hash:(NSString *)aInput
{
    const char *cStr = [aInput UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(CGFloat)heightForText:(NSString*)text withFont:(UIFont *)font andWidth:(CGFloat)width
{
    if ((![text isKindOfClass:[NSNull class]])&& [text length] > 0) {
        CGSize constrainedSize = CGSizeMake(width, MAXFLOAT);
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
        CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        if (requiredHeight.size.width > width) {
            requiredHeight = CGRectMake(0,0,width, requiredHeight.size.height);
        }
        return requiredHeight.size.height;
    }
    return 0;
}

@end
