//
// Created by Jörg Polakowski on 14/12/13.
// Copyright (c) 2013 kevinzhow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PNLineChartDataItem : NSObject

+ (PNLineChartDataItem *)dataItemWithY:(CGFloat)y withColor:(UIColor *)color;

@property (readonly) CGFloat y; // should be within the y range
@property (readonly) UIColor *color;

@end
