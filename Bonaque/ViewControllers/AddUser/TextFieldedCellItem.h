//
//  TextFieldedCellItem.h
//  DentalClinic
//
//  Created by Puujee on 4/2/15.
//  Copyright (c) 2015 CronoSoft Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFieldedCellItem : NSObject
@property (nonatomic, strong) NSString *placeHolderText;
@property (nonatomic, strong) NSString *imageName;

+(TextFieldedCellItem *)createItemWithTitle:(NSString *)title imageName:(NSString *)imageName;


@end
