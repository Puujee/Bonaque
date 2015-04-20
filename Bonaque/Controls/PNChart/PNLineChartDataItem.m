//
// Created by Jörg Polakowski on 14/12/13.
// Copyright (c) 2013 kevinzhow. All rights reserved.
//

#import "PNLineChartDataItem.h"

@interface PNLineChartDataItem ()

- (id)initWithY:(CGFloat)y withColor:(UIColor *)color;

@property (readwrite) CGFloat y; // should be within the y range
@property (readwrite) UIColor *color;
@end

@implementation PNLineChartDataItem

+ (PNLineChartDataItem *)dataItemWithY:(CGFloat)y withColor:(UIColor *)_colorz
{
    return [[PNLineChartDataItem alloc] initWithY:y withColor:_colorz];
}

- (id)initWithY:(CGFloat)y withColor:(UIColor *)_colorz
{
    if ((self = [super init])) {
        self.y = y;
        self.color = _colorz;
    }

    return self;
}

@end
