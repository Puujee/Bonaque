//
//  LanguageManager.h
//  DJTube
//
//  Created by Akuna on 7/16/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageManager : NSObject
@property(nonatomic, strong) NSDictionary *langDictionary;

+ (LanguageManager *)getLanguage;
- (NSDictionary *) getDictionary;
- (NSString *) getStringForKey: (NSString *)key;
- (NSArray *) getArrayForKey:(NSString *)key;

@end
