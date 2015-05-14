//
//  PersonLog.m
//  Bonaque
//
//  Created by Puujee on 4/8/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "PersonLog.h"


@implementation PersonLog

@dynamic id;
@dynamic date;
@dynamic weight;
@dynamic currentWaterLitre;
@dynamic currentWaterPercent;
@dynamic weightBMI;
@dynamic waterGoal;

+(void)createNewPersonLog:(float)height withWeight:(float)weight{
    [PersonLog createNewPersonLog:height withWeight:weight withDate:[NSDate date]];
}

+(void)createNewPersonLog:(float)height withWeight:(float)weight withDate:(NSDate *)date{
    [USERDEF setInteger:0 forKey:kLAST_DRINKED_ML];
    PersonLog   *item = [NSEntityDescription insertNewObjectForEntityForName:@"PersonLog" inManagedObjectContext:DATABASE.managedObjectContext];
    item.weight = [NSNumber numberWithFloat:weight];
    item.date = date;
    item.waterGoal = [NSNumber numberWithFloat:weight *ML_PER_KG];
    int bmiIndex = 0;
    float bmiCalc = (weight / ((height / 100) * (height / 100)));
    if (bmiCalc < BMI_MEASURE_UNDERWEIGHT) {
        bmiIndex = WEIGHT_UNDERWEIGHT_ID;
    }
    if (bmiCalc >= BMI_MEASURE_UNDERWEIGHT && bmiCalc < BMI_MEASURE_NORMAL) {
        bmiIndex = WEIGHT_NORMAL_ID;
    }
    if (bmiCalc >= BMI_MEASURE_NORMAL && bmiCalc < BMI_MEASURE_OVERWEIGHT) {
        bmiIndex = WEIGHT_OVERWEIGHT_ID;
    }
    
    if (bmiCalc >= BMI_MEASURE_OVERWEIGHT) {
        bmiIndex = WEIGHT_OBESE_ID;
    }
    item.weightBMI = [NSNumber numberWithInt:bmiIndex];
    item.currentWaterLitre = [NSNumber numberWithFloat:0];
    item.currentWaterPercent = [NSNumber numberWithFloat:0];
    NSError *error = nil;
    if (![DATABASE.personLogFetchedResultController   performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [DATABASE saveChanges];
}

@end
