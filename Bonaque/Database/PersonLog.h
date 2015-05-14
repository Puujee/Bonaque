//
//  PersonLog.h
//  Bonaque
//
//  Created by Puujee on 4/8/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PersonLog : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSNumber * currentWaterLitre;
@property (nonatomic, retain) NSNumber * currentWaterPercent;
@property (nonatomic, retain) NSNumber * weightBMI;
@property (nonatomic, retain) NSNumber * waterGoal;


+(void)createNewPersonLog:(float)height withWeight:(float)weight;

+(void)createNewPersonLog:(float)height withWeight:(float)weight withDate:(NSDate *)date;


@end
