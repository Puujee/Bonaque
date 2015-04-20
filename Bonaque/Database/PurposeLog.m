//
//  PurposeLog.m
//  Bonaque
//
//  Created by Puujee on 4/9/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "PurposeLog.h"


@implementation PurposeLog

@dynamic purposeLogID;
@dynamic daysRemaining;
@dynamic endDate;

+(void)createPurposeLog{
    Purpose *purposeItem;
    PurposeLog *lastPurposeItem = [[[DATABASE purposeLogFetchedResultController] fetchedObjects] lastObject];
    if (lastPurposeItem) {
        purposeItem = [DATABASE getPurposeID:lastPurposeItem.purposeLogID.intValue + 1];
    }
    else{
        purposeItem = [[DATABASE getpurposeLanguageArray] objectAtIndex:0];

    }
    if (purposeItem) {
        NSDate *date;
        if ([[[DATABASE purposeLogFetchedResultController] fetchedObjects] count]> 0) {
           NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

            unsigned unitFlagsDate = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour;
            NSDateComponents *dateComponents = [gregorian components:unitFlagsDate fromDate:[NSDate date]];
            dateComponents.hour += 1;
            date = [gregorian dateFromComponents:dateComponents];
        }
        PurposeLog   *item = [NSEntityDescription insertNewObjectForEntityForName:@"PurposeLog" inManagedObjectContext:DATABASE.managedObjectContext];
        item.purposeLogID = purposeItem.purposeID;
        item.endDate = date;
        item.daysRemaining = purposeItem.days;
        
        NSError *error = nil;
        if (![DATABASE.purposeLogFetchedResultController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [DATABASE saveChanges];
    }
}

@end
