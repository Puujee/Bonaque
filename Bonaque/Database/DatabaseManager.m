//
//  DatabaseManager.m
//  Bonaque
//
//  Created by Puujee on 4/9/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

+(void)setAdvices{
    NSData *adviceEn = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"advices_en" ofType:@"json"]];
    NSError *errorEn;
    NSDictionary *dicEN = [NSJSONSerialization JSONObjectWithData:adviceEn options:NSJSONReadingMutableContainers error:&errorEn];
    if (!errorEn) {
        NSArray *enArray = [dicEN objectForKey:@"advices"];
        for (NSDictionary *dic in enArray) {
            Advice   *item = [NSEntityDescription insertNewObjectForEntityForName:@"Advice" inManagedObjectContext:DATABASE.managedObjectContext];
            item.language  = [NSNumber numberWithInt:0];
            item.id = [NSNumber numberWithInt:[dic[@"id"] intValue]];
            item.title = dic[@"title"];
            item.content = dic[@"content"];
            item.icon = dic[@"icon"];
        }
    }
    NSData *adviceMn = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"advices_mn" ofType:@"json"]];
    NSError *errorMn;
    NSDictionary *dicMN = [NSJSONSerialization JSONObjectWithData:adviceMn options:NSJSONReadingMutableContainers error:&errorMn];
    if (!errorMn) {
        NSArray *mnArray = [dicMN objectForKey:@"advices"];
        for (NSDictionary *dic in mnArray) {
            Advice   *item = [NSEntityDescription insertNewObjectForEntityForName:@"Advice" inManagedObjectContext:DATABASE.managedObjectContext];
            item.language  = [NSNumber numberWithInt:1];
            item.id = [NSNumber numberWithInt:[dic[@"id"] intValue]];
            item.title = dic[@"title"];
            item.content = dic[@"content"];
            item.icon = dic[@"icon"];
        }
    }
    
    NSError *error1 = nil;
    if (![DATABASE.adviceFetchedResultController   performFetch:&error1]) {
        NSLog(@"Unresolved error %@, %@", error1, [error1 userInfo]);
        abort();
    }
    [DATABASE saveChanges];
}

+(void)setCup{
    NSData *cupData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cups" ofType:@"json"]];
    NSError *errorEn;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:cupData options:NSJSONReadingMutableContainers error:&errorEn];
    if (!errorEn) {
        NSArray *enArray = [dic objectForKey:@"cups"];
        for (NSDictionary *dic in enArray) {
            Cup   *item = [NSEntityDescription insertNewObjectForEntityForName:@"Cup" inManagedObjectContext:DATABASE.managedObjectContext];
            item.id = [NSNumber numberWithInt:[dic[@"id"] intValue]];
            item.icon = dic[@"icon"];
            item.ml = [NSNumber numberWithInt:[dic[@"ml"] intValue]];
        }
    }
    
    NSError *error1 = nil;
    if (![DATABASE.cupFetchedResultController   performFetch:&error1]) {
        NSLog(@"Unresolved error %@, %@", error1, [error1 userInfo]);
        abort();
    }
    [DATABASE saveChanges];
}

+(void)setPurpose{
    NSData *purposeEn = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"purposes_en" ofType:@"json"]];
    NSError *errorEn;
    NSDictionary *dicEN = [NSJSONSerialization JSONObjectWithData:purposeEn options:NSJSONReadingMutableContainers error:&errorEn];
    if (!errorEn) {
        NSArray *enArray = [dicEN objectForKey:@"purposes"];
        for (NSDictionary *dic in enArray) {
            Purpose   *item = [NSEntityDescription insertNewObjectForEntityForName:@"Purpose" inManagedObjectContext:DATABASE.managedObjectContext];
            item.language  = [NSNumber numberWithInt:0];
            item.purposeID = [NSNumber numberWithInt:[dic[@"id"] intValue]];
            item.title = dic[@"title"];
            item.days = [NSNumber numberWithInt:[dic[@"days"] intValue]];
            item.icon = dic[@"icon"];
            item.content = dic[@"content"];

        }
    }
    NSData *purposeMn = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"purposes_mn" ofType:@"json"]];
    NSError *errorMn;
     NSDictionary *dicMN = [NSJSONSerialization JSONObjectWithData:purposeMn options:NSJSONReadingMutableContainers error:&errorMn];
    if (!errorMn) {
        NSArray *mnArray = [dicMN objectForKey:@"purposes"];
        for (NSDictionary *dic in mnArray) {
            Purpose   *item = [NSEntityDescription insertNewObjectForEntityForName:@"Purpose" inManagedObjectContext:DATABASE.managedObjectContext];
            item.language  = [NSNumber numberWithInt:1];
            item.purposeID = [NSNumber numberWithInt:[dic[@"id"] intValue]];
            item.title = dic[@"title"];
            item.days = [NSNumber numberWithInt:[dic[@"days"] intValue]];
            item.icon = dic[@"icon"];
            item.content = dic[@"content"];
        }
    }
    
    NSError *error1 = nil;
    if (![DATABASE.purposeFetchedResultController   performFetch:&error1]) {
        NSLog(@"Unresolved error %@, %@", error1, [error1 userInfo]);
        abort();
    }
    [DATABASE saveChanges];
}



@end
