//
//  MenuItem.h
//  Bondooloi
//
//  Created by Puujee on 10/30/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 * @brief Menu-н нэр icon-н object
 */


@interface MenuItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;

+(MenuItem *)createItemWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end
