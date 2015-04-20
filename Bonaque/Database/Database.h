//
//  Datenbank.h
//  CoreDataCluster
//
//  Created by mm on 28.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Person.h"
#import "PersonLog.h"
#import "Purpose.h"
#import "PurposeLog.h"
#import "Advice.h"
#import "Cup.h"

@interface Database : NSObject <NSFetchedResultsControllerDelegate>  {
	
	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSFetchedResultsController *productCategory;
}

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSFetchedResultsController *personFetchedResultController;
@property (nonatomic, strong) NSFetchedResultsController *personLogFetchedResultController;
@property (nonatomic, strong) NSFetchedResultsController *purposeFetchedResultController;
@property (nonatomic, strong) NSFetchedResultsController *purposeLogFetchedResultController;
@property (nonatomic, strong) NSFetchedResultsController *adviceFetchedResultController;
@property (nonatomic, strong) NSFetchedResultsController *cupFetchedResultController;



+ (Database *) getDatabase;
- (void) clearAllDataBase;
- (void) saveChanges;


-(NSArray *)getpurposeLanguageArray;
-(NSArray *)getAdviceLanguageArray;
-(NSArray *)getWinnedPurpose;

-(Person *)getUser;
-(PersonLog *)getTodaysPersonLog;
-(PersonLog *)getPersonLogWithDate:(NSDate *)date;
-(Cup *)getCupWithID:(int)cupID;
-(Purpose *)getPurposeID:(int)_id;
-(Purpose *)getNextPurposeWithID:(int)_id;
-(PurposeLog *)getPurposeLogWithID:(int)_id;
-(Advice *)getRandomAdvice ;

-(void)updatePurposeLog;
-(void)updateWeightLastPersonLog;

-(void)clearPersonLog;
-(void)clearPersons;

-(BOOL)isHaveCupMl:(float)ml;

-(float)getAllDrinkedWater;
-(float)getAverageDrinkedWater;
-(float)getMinimumWeight;
-(float)getMaximumWeight;

@end









