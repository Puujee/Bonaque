//
//  TextFieldedCellItem.m
//  DentalClinic
//
//  Created by Puujee on 4/2/15.
//  Copyright (c) 2015 CronoSoft Ltd. All rights reserved.
//

#import "TextFieldedCellItem.h"

@implementation TextFieldedCellItem

@synthesize placeHolderText;
@synthesize imageName;

+(TextFieldedCellItem *)createItemWithTitle:(NSString *)title imageName:(NSString *)imageName{
    TextFieldedCellItem *item = [[TextFieldedCellItem alloc] init];
    item.placeHolderText = title;
    item.imageName = imageName;
    return item;
}

@end
