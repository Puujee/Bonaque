//
//  Utils.m
//  Bondooloi
//
//  Created by L on 10/1/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import "Utils.h"
#import "PurposeCongrulateDialog.h"

#define CALL 326

@interface Utils ()


@end

@implementation Utils

Utils     *sharedUtils;

+ (Utils *)getUtils{
    @synchronized(self)
    {
        if (!sharedUtils) {
            sharedUtils = [[Utils alloc] init];
        }
    }
    return sharedUtils;
}

+ (void) showAlert:(NSString *)message {
    UIAlertView *customAlertView = [[UIAlertView alloc]initWithTitle:@"Bonaqua" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [customAlertView show];
}

+(void)setAlarm:(NSString *)title withDate:(NSString *)date{
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    NSDate* result = [Utils dateFromHouurs:date];

    ATLog(@"%@", result);
    localNotification.fireDate = result;
    localNotification.alertBody = title;
    localNotification.alertAction = @"Bonaqua app";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    [localNotification setRepeatInterval: NSCalendarUnitDay];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//    [Utils showAlert:[NSString stringWithFormat:@"%@ өдөр тэмдэглэгдлээ. Та МИНИЙ БУЛАН хэсэг рүү орж тэмдэглэсэн үзвэрүүдээ харах боломжтой", date]];
}

+(void)setAlarmSchedule{
    [Utils  removeLocalNotification:@"Ус уух цаг боллоо"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
//    ATLog(@"%@", [USERDEF valueForKey:kSTART_TIME]);
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *startTime = [dateFormatter dateFromString:[USERDEF valueForKey:kSTART_TIME]];
    unsigned unitFlagsTime = NSCalendarUnitHour | NSCalendarUnitMinute |  NSCalendarUnitSecond;
    NSDateComponents *startTimeComponents = [gregorian components:unitFlagsTime fromDate:startTime];
    
    NSInteger startHour = startTimeComponents.hour;
    NSInteger startMinute = startTimeComponents.minute;
    
    NSDate *endTime = [dateFormatter dateFromString:[USERDEF valueForKey:kEND_TIME]];
    NSDateComponents *endTimeComponents = [gregorian components:unitFlagsTime fromDate:endTime];
    
    NSInteger endHour = endTimeComponents.hour;
//    NSInteger endMinute = endTimeComponents.minute;
    
    int lastNotifHour = (int)startHour;
    int lastNotifMinute = (int)startMinute;
    int intervalHour = 0;
    int intervalMinute = 0;
    
    int interval = (int)[USERDEF integerForKey:kINTERVAL];
    if (interval == 0) {
        intervalMinute = 15;
    }
    else if (interval == 1){
        intervalMinute = 30;
    }
    else if (interval == 2){
        intervalHour = 1;
    }
    else if (interval == 3){
        intervalHour = 2;
    }
    else if (interval == 4){
        intervalHour = 3;
    }
    else if (interval == 5){
        intervalHour = 4;
    }
    
    for (int i = (int)startHour; i < endHour; i++) {
        for (int z = 0; z < 60; z++) {
            if (i == lastNotifHour && z == lastNotifMinute) {
                [Utils setAlarm:[LANGUAGE getStringForKey:@"notif_title"] withDate:[NSString stringWithFormat:@"%ld:%ld", (long)lastNotifHour, (long)lastNotifMinute]];
                lastNotifHour += intervalHour;
                lastNotifMinute += intervalMinute;
            }
            if (lastNotifMinute >= 60) {
                lastNotifHour += 1;
                lastNotifMinute = lastNotifMinute - 60;
//                ATLog(@"%@:%@", lastNotifHour, lastNotifMinute);
            }
        }
        if (lastNotifHour > endHour) {
            break;
        }
    }
//    UIApplication *app = [UIApplication sharedApplication];
//    ATLog(@"%@", [app scheduledLocalNotifications]);
    
}

+(NSDate *)dateFromHouurs:(NSString *)hour{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    unsigned unitFlagsDate = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *dateComponents = [gregorian components:unitFlagsDate fromDate:[NSDate date]];
    unsigned unitFlagsTime = NSCalendarUnitHour | NSCalendarUnitMinute |  NSCalendarUnitSecond;
    NSDateComponents *timeComponents = [gregorian components:unitFlagsTime fromDate:[dateFormatter dateFromString:hour]];
    
    [dateComponents setHour:[timeComponents hour]];
    [dateComponents setMinute:[timeComponents minute]];
    
    return [gregorian dateFromComponents:dateComponents];;
}

+(void)changeAllNotificationsSound{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    NSString *soundName = UILocalNotificationDefaultSoundName;
    if ([USERDEF integerForKey:kSELECTED_SOUND] == 1) {
        soundName = @"water_sound";
    }
    else if ([USERDEF integerForKey:kSELECTED_SOUND] == 2){
        soundName = @"drink_sound";
    }
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        oneEvent.soundName = soundName;
            NSLog(@"the notification this is canceld is %@", oneEvent.alertBody);
    }
}


+(void)removeLocalNotification:(NSString *)title{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *eventArray = [app scheduledLocalNotifications];
    for (int i=0; i<[eventArray count]; i++)
    {
        UILocalNotification* oneEvent = [eventArray objectAtIndex:i];
        if ([oneEvent.alertBody isEqualToString:title]) {
            NSLog(@"the notification this is canceld is %@", oneEvent.alertBody);
            [[UIApplication sharedApplication] cancelLocalNotification:oneEvent] ; // delete the notification from the system
        }
    }
}

+(void)showCongrulatePurpose:(Purpose *)item{
    PurposeCongrulateDialog *pickerContainer = [[PurposeCongrulateDialog alloc] initWithFrame:[[APPDEL window] bounds]];
//    pickerContainer.delegate = self;
    pickerContainer.item = item;
    pickerContainer.mainViewController = [[APPDEL viewController]  revealViewController];
    pickerContainer.tag  = 201;
    [[APPDEL window] addSubview:pickerContainer];
    
    [pickerContainer showContentView];
    
}

#pragma mark SoundPlay

+(SystemSoundID)createSystemSoundId:(NSString*)filename {
    
    SystemSoundID soundID;
    
    OSStatus err = kAudioServicesNoError;
    if (filename == nil) {
        soundID = kSystemSoundID_Vibrate;
    }
    else {
        NSString *cafPath =
        [[NSBundle mainBundle] pathForResource:filename ofType:@""];
        NSURL *cafURL = [NSURL fileURLWithPath:cafPath];
        err = AudioServicesCreateSystemSoundID((__bridge CFURLRef) cafURL, &soundID);
    }
    if (err != kAudioServicesNoError) {
        return 0;
    } 
    return  soundID;
}

+(void)playSystemSoundWithName:(NSString *)path {
    SystemSoundID endRecordMessageSound = [Utils createSystemSoundId:path];
    ATLog(@"%@", endRecordMessageSound);
    if (endRecordMessageSound == 0) {
        ATLog(@"can not play endRecordMessageSound");
    }
    else {
        AudioServicesPlaySystemSound (endRecordMessageSound);
    }
}


+(int)getIntervalWeightReminder{
    int interval = (int)[USERDEF integerForKey:kWEIGHT_INTERVAL];
    int day;
    if (interval == 0) {
        day = 1;
    }
    else if (interval == 1){
        day = 3;
    }
    else if (interval == 2){
        day = 7;
    }
    else if (interval == 3){
        day = 14;
    }
    else if (interval == 4){
        day = 21;
    }
    else if (interval == 5){
        day = 30;
    }
    else if (interval == 6){
        day = 60;
    }
    return day;
}

+(void)showScheduledAlert:(UIView *)viewP{
    
}

@end
