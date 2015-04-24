//
//  Utils.h
//  Bondooloi
//
//  Created by L on 10/1/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import <MessageUI/MFMailComposeViewController.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>


/*!
 * @brief Аппанд нийтлэг ашиглагдаж байгаа функцуудийн Class
 */

@interface Utils : NSObject

+ (Utils *)getUtils;

/*!
 *  Аппад алерт харуулна.
 *
 *  @param message Алертийн текст
 */
+ (void) showAlert:(NSString *)message;

+(void)setAlarm:(NSString *)title withDate:(NSString *)date;
+(void)setAlarmSchedule;
+(void)removeLocalNotification:(NSString *)title;
+(void)removeAllLocalNotification;

+(NSDate *)dateFromHouurs:(NSString *)hour;

+(SystemSoundID)createSystemSoundId:(NSString*)filename withExtension:(NSString *)ext;
+(void)playSystemSoundWithName:(NSString *)path withExtension:(NSString *)ext;

+(void)showCongrulatePurpose:(Purpose *)item;

+(int)getIntervalWeightReminder;

@end
