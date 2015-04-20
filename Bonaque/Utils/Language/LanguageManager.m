//
//  LanguageManager.m
//  DJTube
//
//  Created by Akuna on 7/16/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import "LanguageManager.h"

@implementation LanguageManager
@synthesize langDictionary;

LanguageManager *sharedLanguage;

+ (LanguageManager *)getLanguage
{
	@synchronized(self)
	{
		if (!sharedLanguage) {
			sharedLanguage = [[LanguageManager alloc] init];
            NSString *path = [[NSBundle mainBundle] bundlePath];
            NSString *finalPath = [path stringByAppendingPathComponent:@"Language.plist"];
            NSArray *tempDictionary = [NSArray arrayWithContentsOfFile:finalPath];
            sharedLanguage.langDictionary = [tempDictionary objectAtIndex:[USERDEF integerForKey:kSELECTED_LANGUAGE]];
		}
	}
	return sharedLanguage;
}

- (NSDictionary *) getDictionary {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"Language.plist"];
    NSArray *tempDictionary = [NSArray arrayWithContentsOfFile:finalPath];
    return  [tempDictionary objectAtIndex:[USERDEF integerForKey:kSELECTED_LANGUAGE]];
}

//- (NSArray *) getLanguageKeys{
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSString *finalPath = [path stringByAppendingPathComponent:@"Language.plist"];
//    NSDictionary *tempDictionary = [NSDictionary dictionaryWithContentsOfFile:finalPath];
//    NSArray *tempArray = [tempDictionary objectForKey:@"languages"];
//    return tempArray;
//}
//- (NSDictionary *) getLanguageNames{
//    NSString *path = [[NSBundle mainBundle] bundlePath];
//    NSString *finalPath = [path stringByAppendingPathComponent:@"Language.plist"];
//    NSDictionary *tempDictionary = [NSDictionary dictionaryWithContentsOfFile:finalPath];
//    NSDictionary *tempArray = [tempDictionary objectForKey:@"languageNames"];
//    return tempArray;
//}

- (NSString *) getStringForKey: (NSString *)key {
    
    NSDictionary *dictionary = [self getDictionary];
    
    if (dictionary)
    {
        NSString *object = [dictionary objectForKey:key];
        if (object)
        {
            return object;
        }
    }
    return key;
}

- (NSArray *) getArrayForKey:(NSString *)key{
    NSDictionary *dictionary = [self getDictionary];
    
    if (dictionary)
    {
        NSArray *object = [dictionary objectForKey:key];
        if (object)
        {
            return object;
        }
    }
    return nil;
}
@end
