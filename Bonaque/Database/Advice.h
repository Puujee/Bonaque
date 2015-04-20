//
//  Advice.h
//  Bonaque
//
//  Created by Puujee on 4/9/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Advice : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * language;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;

@end
