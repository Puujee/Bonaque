//
//  GSTextField.m
//  BarilgaMn
//
//  Created by Gantulga Tsendsuren on 10/4/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import "GSTextField.h"

@implementation GSTextField
@synthesize indexPath;
@synthesize placeHolderTextColor;
@synthesize placeHolderFontSize;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.placeHolderFontSize = 16;
        self.placeHolderTextColor = [UIColor lightGrayColor];

    }
    return self;
}

- (void) drawPlaceholderInRect:(CGRect)rect {
    rect.origin.y = CGRectGetMidY(self.bounds) - 11;
    rect.origin.x = 2;
    [placeHolderTextColor setFill];
    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName:
                                                             [UIFont fontWithName:MAIN_LIGHT_FONT size:self.placeHolderFontSize], NSForegroundColorAttributeName:[UIColor grayColor]}];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
