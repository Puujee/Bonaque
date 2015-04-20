//
//  SettingsItem.m
//  Bonaque
//
//  Created by Puujee on 4/4/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "SettingsItem.h"

@implementation SettingsItem
@synthesize itsHaveCheckBox;
@synthesize title;
@synthesize description;

+(SettingsItem *)createItemWithTitle:(NSString *)title description:(NSString *)imageName itsHaveCheckBox:(BOOL)anyCheckbox{
    SettingsItem *item = [[SettingsItem alloc] init];
    item.title = title;
    item.description = imageName;
    item.itsHaveCheckBox = anyCheckbox;
    return item;
}

@end
