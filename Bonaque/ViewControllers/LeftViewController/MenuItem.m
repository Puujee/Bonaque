//
//  MenuItem.m
//  Bondooloi
//
//  Created by Puujee on 10/30/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem
@synthesize  title;
@synthesize  imageName;

+(MenuItem *)createItemWithTitle:(NSString *)title imageName:(NSString *)imageName{
    MenuItem *item = [[MenuItem alloc] init];
    item.title = title;
    item.imageName = imageName;
    return item;
}

@end
