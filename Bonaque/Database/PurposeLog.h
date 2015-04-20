//
//  PurposeLog.h
//  Bonaque
//
//  Created by Puujee on 4/9/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PurposeLog : NSManagedObject

@property (nonatomic, retain) NSNumber * purposeLogID;
@property (nonatomic, retain) NSNumber * daysRemaining;
@property (nonatomic, retain) NSDate * endDate;

+(void)createPurposeLog;


@end
