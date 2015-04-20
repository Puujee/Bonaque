//
//  Datenbank.m
//  CoreDataCluster
//
//  Created by mm on 28.01.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Database.h"

@interface Database(){
    NSCalendar *gregorian ;

}

- (NSString *)applicationDocumentsDirectory;
- (void)myInit;

@end

@implementation Database
@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;
@synthesize personFetchedResultController;
@synthesize personLogFetchedResultController;
@synthesize purposeFetchedResultController;
@synthesize purposeLogFetchedResultController;
@synthesize adviceFetchedResultController;
@synthesize cupFetchedResultController;

#pragma mark -
#pragma mark Core Data stack
Database *sharedDatabase;

+ (Database *)getDatabase 
{	
	
	@synchronized(self)
	{
		if (!sharedDatabase) {
			sharedDatabase = [[Database alloc] init];
			[sharedDatabase myInit];
		}
	}	
	return sharedDatabase;
}

- (void)myInit
{
	managedObjectContext = self.managedObjectContext;
    {
		NSError *error = nil;
		if (![[self personFetchedResultController] performFetch:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}
    {
        NSError *error = nil;
        if (![[self personLogFetchedResultController] performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    {
        NSError *error = nil;
        if (![[self purposeFetchedResultController] performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    {
        NSError *error = nil;
        if (![[self purposeLogFetchedResultController] performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    {
        NSError *error = nil;
        if (![[self adviceFetchedResultController] performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    {
        NSError *error = nil;
        if (![[self cupFetchedResultController] performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    [self saveChanges];
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
}

- (void)saveChanges
{
	NSError *error;
    if (self.managedObjectContext != nil) {
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}

- (void) clearAllDataBase {
    {
        NSArray *inboxArray = [self.personFetchedResultController fetchedObjects];
        for (NSManagedObject *obj in inboxArray) {
            [self.managedObjectContext deleteObject:obj];
        }
        NSError *error = nil;
        if (![self.personFetchedResultController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    {
        NSArray *inboxArray = [self.personLogFetchedResultController fetchedObjects];
        for (NSManagedObject *obj in inboxArray) {
            [self.managedObjectContext deleteObject:obj];
        }
        NSError *error = nil;
        if (![self.personLogFetchedResultController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    {
        NSArray *inboxArray = [self.purposeFetchedResultController fetchedObjects];
        for (NSManagedObject *obj in inboxArray) {
            [self.managedObjectContext deleteObject:obj];
        }
        NSError *error = nil;
        if (![self.purposeFetchedResultController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    {
        NSArray *inboxArray = [self.purposeLogFetchedResultController fetchedObjects];
        for (NSManagedObject *obj in inboxArray) {
            [self.managedObjectContext deleteObject:obj];
        }
        NSError *error = nil;
        if (![self.purposeLogFetchedResultController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    {
        NSArray *inboxArray = [self.adviceFetchedResultController fetchedObjects];
        for (NSManagedObject *obj in inboxArray) {
            [self.managedObjectContext deleteObject:obj];
        }
        NSError *error = nil;
        if (![self.adviceFetchedResultController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    {
        NSArray *inboxArray = [self.cupFetchedResultController fetchedObjects];
        for (NSManagedObject *obj in inboxArray) {
            [self.managedObjectContext deleteObject:obj];
        }
        NSError *error = nil;
        if (![self.cupFetchedResultController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    [self saveChanges];
}


-(void)clearPersons{
    {
        NSArray *inboxArray = [self.personFetchedResultController fetchedObjects];
        for (NSManagedObject *obj in inboxArray) {
            [self.managedObjectContext deleteObject:obj];
        }
        NSError *error = nil;
        if (![self.personFetchedResultController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    [self saveChanges];
}

-(void)clearPersonLog{
    {
        NSArray *inboxArray = [self.personLogFetchedResultController fetchedObjects];
        for (NSManagedObject *obj in inboxArray) {
            [self.managedObjectContext deleteObject:obj];
        }
        NSError *error = nil;
        if (![self.personLogFetchedResultController performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    [self saveChanges];
}

#pragma mark -
#pragma mark Database required methods

- (NSManagedObjectContext *) managedObjectContext 
{
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel 
{
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator 
{
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
	
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Bonaque.sqlite"];
	/*
	 Set up the store.
	 For the sake of illustration, provide a pre-populated default store.
	 */
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// If the expected store doesn't exist, copy the default store.
	if (![fileManager fileExistsAtPath:storePath]) {
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"Bonaque" ofType:@"sqlite"];
		if (defaultStorePath) {
			[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
		}
	}
	
	NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], 
							 NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];	
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
	
	NSError *error;
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }
    NSDictionary *fileAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
    [[NSFileManager defaultManager] setAttributes:fileAttributes ofItemAtPath:storePath error:&error];
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory 
{
	return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)personFetchedResultController
{
    if (personFetchedResultController != nil) {
        return personFetchedResultController;
    }
    
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:managedObjectContext];
	
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchBatchSize:200];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"userID" ascending:YES];

	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
	self.personFetchedResultController = aFetchedResultsController;
	return personFetchedResultController;
}

- (NSFetchedResultsController *)personLogFetchedResultController
{
    if (personLogFetchedResultController != nil) {
        return personLogFetchedResultController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PersonLog" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:200];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    self.personLogFetchedResultController = aFetchedResultsController;
    return personLogFetchedResultController;
}

- (NSFetchedResultsController *)purposeFetchedResultController
{
    if (purposeFetchedResultController != nil) {
        return purposeFetchedResultController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Purpose" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:200];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"days" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    self.purposeFetchedResultController = aFetchedResultsController;
    return purposeFetchedResultController;
}

- (NSFetchedResultsController *)purposeLogFetchedResultController
{
    if (purposeLogFetchedResultController != nil) {
        return purposeLogFetchedResultController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PurposeLog" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:200];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"endDate" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    self.purposeLogFetchedResultController = aFetchedResultsController;
    return purposeLogFetchedResultController;
}

- (NSFetchedResultsController *)adviceFetchedResultController
{
    if (adviceFetchedResultController != nil) {
        return adviceFetchedResultController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Advice" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:200];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    self.adviceFetchedResultController = aFetchedResultsController;
    return adviceFetchedResultController;
}

- (NSFetchedResultsController *)cupFetchedResultController
{
    if (cupFetchedResultController != nil) {
        return cupFetchedResultController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Cup" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:200];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    self.cupFetchedResultController = aFetchedResultsController;
    return cupFetchedResultController;
}

-(NSArray *)getAdviceLanguageArray{
    NSArray *adviceArray = [self.adviceFetchedResultController fetchedObjects];
//    NSMutableArray *tempArray = [NSMutableArray array];
//    for (Advice *item in adviceArray) {
//        if (item.language.intValue == [USERDEF integerForKey:kSELECTED_LANGUAGE]) {
//            [tempArray addObject:item];
//        }
//    }
    return adviceArray;
}

-(NSArray *)getpurposeLanguageArray{
    NSArray *adviceArray = [self.purposeFetchedResultController fetchedObjects];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (Purpose *item in adviceArray) {
        if (item.language.intValue == [USERDEF integerForKey:kSELECTED_LANGUAGE]) {
            [tempArray addObject:item];
        }
    }
    return tempArray;
}


-(Person *)getUser{
    NSArray *persons = [personFetchedResultController fetchedObjects];
    if (persons.count > 0) {
        return [persons objectAtIndex:0];
    }
    return nil;
}

-(PersonLog *)getTodaysPersonLog{
    PersonLog *item = [[self.personLogFetchedResultController fetchedObjects] lastObject];
    
    unsigned unitFlagsDate = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *dateComponents = [gregorian components:unitFlagsDate fromDate:[NSDate date]];
    NSDateComponents *timeComponents = [gregorian components:unitFlagsDate fromDate:item.date];
    
    if (dateComponents.year == timeComponents.year && dateComponents.month == timeComponents.month && dateComponents.day == timeComponents.day) {
        return item ;
    }
    Person *user = [self getUser];
    [PersonLog createNewPersonLog:user.height.floatValue withWeight:user.weight.floatValue];
    item = [[self.personLogFetchedResultController fetchedObjects] lastObject];
    return item;
}

-(PersonLog *)getPersonLogWithDate:(NSDate *)date{
    NSArray *items = [self.personLogFetchedResultController fetchedObjects];
    
    unsigned unitFlagsDate = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *dateComponents = [gregorian components:unitFlagsDate fromDate:date];
    
    for (PersonLog *item in items) {
        NSDateComponents *timeComponents = [gregorian components:unitFlagsDate fromDate:item.date];
        if (dateComponents.year == timeComponents.year && dateComponents.month == timeComponents.month && dateComponents.day == timeComponents.day) {
            return item ;
        }
    }
    return nil;
}

-(void)updatePurposeLog{
    if ([[self.purposeLogFetchedResultController fetchedObjects] count] == 0) {
        [PurposeLog createPurposeLog];
    }
    PurposeLog *item = [[self.purposeLogFetchedResultController fetchedObjects] lastObject];
    if (item.daysRemaining.intValue == 0) {
        [PurposeLog createPurposeLog];
    }
    unsigned unitFlagsDate = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *dateComponents = [gregorian components:unitFlagsDate fromDate:[NSDate date]];
    NSDateComponents *timeComponents = [gregorian components:unitFlagsDate fromDate:item.endDate];
    
    if (dateComponents.day == timeComponents.day && dateComponents.year == timeComponents.year && dateComponents.month == timeComponents.month) {
        return;
    }
    item.daysRemaining = [NSNumber numberWithInt:item.daysRemaining.intValue - 1];
    item.endDate = [NSDate date];
    NSError *error = nil;
    if (![DATABASE.purposeLogFetchedResultController   performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [DATABASE saveChanges];
    if (item.daysRemaining.intValue == 0) {
        [PurposeLog createPurposeLog];
        [Utils showCongrulatePurpose:[self getPurposeID:item.purposeLogID.intValue]];
    }
}

-(void)updateWeightLastPersonLog{
    Person *user = [self getUser];
    PersonLog *item = [self getTodaysPersonLog];
    item.weight = user.weight;
    item.waterGoal = [NSNumber numberWithFloat:user.weight.floatValue *ML_PER_KG];
    int bmiIndex = 0;
    float bmiCalc = (user.weight.floatValue / ((user.height.floatValue / 100) * (user.height.floatValue / 100)));
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
    NSError *error = nil;
    if (![DATABASE.personLogFetchedResultController   performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    [DATABASE saveChanges];
}


-(Cup *)getCupWithID:(int)cupID{
    NSArray *cupsArray = self.cupFetchedResultController.fetchedObjects;
    for (Cup *item in cupsArray) {
        if (item.id.intValue == cupID) {
            return item;
        }
    }
    return nil;
}

-(Advice *)getRandomAdvice {
    NSArray *adviceArrays = [self getAdviceLanguageArray];
    int randomIndex = arc4random() %adviceArrays.count;
    return [adviceArrays objectAtIndex:randomIndex];
}

-(Purpose *)getPurposeID:(int)_id{
    NSArray *purposeArray = [self getpurposeLanguageArray];
    for (Purpose *item in purposeArray) {
        if (item.purposeID.intValue == _id) {
            return item;
        }
    }
    return nil;
}

-(Purpose *)getNextPurposeWithID:(int)_id{
    NSArray *purposeArray = [self getpurposeLanguageArray];
    NSInteger index = [purposeArray indexOfObject:[DATABASE getPurposeID:_id]] + 1;
    if (purposeArray.count > index) {
        Purpose *purpose = [purposeArray objectAtIndex:index];
        return purpose;
    }
    return nil;
}

-(PurposeLog *)getPurposeLogWithID:(int)_id{
    NSArray *purposeArray = self.purposeLogFetchedResultController.fetchedObjects;
    for (PurposeLog *item in purposeArray) {
        if (item.purposeLogID.intValue == _id) {
            return item;
        }
    }
    return nil;
}

-(NSArray *)getWinnedPurpose{
    NSMutableArray *tempArray = [NSMutableArray array];
    NSArray *purposeArray = self.purposeLogFetchedResultController.fetchedObjects;
    for (PurposeLog *item in purposeArray) {
        if (item.daysRemaining.intValue == 0) {
            [tempArray addObject:[DATABASE getPurposeID:item.purposeLogID.intValue]];
        }
    }
    return tempArray;
}


-(BOOL)isHaveCupMl:(float)ml{
    NSArray *cups = [self.cupFetchedResultController fetchedObjects];
    BOOL isHave = NO;
    for (Cup *item in cups) {
        if (item.ml.floatValue == ml) {
            isHave = YES;
            break;
        }
    }
    return isHave;
}


-(float)getAllDrinkedWater{
    float all = 0;
    NSArray *itemArray = [self.personLogFetchedResultController fetchedObjects];
    for (PersonLog *item in itemArray) {
        all += item.currentWaterLitre.floatValue;
    }
    return all;
}

-(float)getAverageDrinkedWater{
    float all    = [self getAllDrinkedWater];
    return all/ [[self.personLogFetchedResultController fetchedObjects] count];
}

-(float)getMinimumWeight{
    float min = 1000;
    NSArray *itemArray = [self.personLogFetchedResultController fetchedObjects];
    for (PersonLog *item in itemArray) {
        if (item.weight.floatValue < min) {
            min = item.weight.floatValue;
        }
    }
    return min;
}

-(float)getMaximumWeight{
    float max = 0;
    NSArray *itemArray = [self.personLogFetchedResultController fetchedObjects];
    for (PersonLog *item in itemArray) {
        if (item.weight.floatValue > max) {
            max = item.weight.floatValue;
        }
    }
    return max;
}


@end
