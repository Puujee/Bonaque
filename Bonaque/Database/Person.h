//
//  Person.h
//  Bonaque
//
//  Created by Puujee on 4/8/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSString * img_url;
@end
