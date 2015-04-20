//
//  SettingsItem.h
//  Bonaque
//
//  Created by Puujee on 4/4/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsItem : NSObject

@property (nonatomic, assign) BOOL itsHaveCheckBox;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;

+(SettingsItem *)createItemWithTitle:(NSString *)title description:(NSString *)imageName itsHaveCheckBox:(BOOL)anyCheckbox;


@end
