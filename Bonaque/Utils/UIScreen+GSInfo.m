//
//  UIScreen+GSInfo.m
//  Tale
//
//  Created by Gantulga Tsendsuren on 7/3/14.
//  Copyright (c) 2014 Sorako LLC. All rights reserved.
//

#import "UIScreen+GSInfo.h"

@implementation UIScreen (GSInfo)

+ (BOOL)isRetina
{
    return ([UIScreen mainScreen].scale == 2.0);
}
+ (BOOL)isiPhone4
{
    return [[UIScreen mainScreen] bounds].size.height == 480;
}
+ (BOOL)isiPhone5
{
    return [[UIScreen mainScreen] bounds].size.height == 568;
}
+ (BOOL)isiPhone6
{
    return [[UIScreen mainScreen] bounds].size.height == 667;
}
+ (BOOL)isiPhone6Plus
{
    return [[UIScreen mainScreen] bounds].size.height == 736;
}
@end
