//
//  EmptyCollectionViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/16/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "EmptyCollectionViewCell.h"

@interface EmptyCollectionViewCell (){
    UIView *bgView;
    UILabel *label;
    UIImageView *imageView;
}

@end

@implementation EmptyCollectionViewCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        
        bgView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [bgView.layer setCornerRadius:4];
        bgView.clipsToBounds = YES;
        [bgView.layer setBorderColor:UIColorFromRGB(0xd8d8d8).CGColor];
        [bgView.layer setBorderWidth:1];
        [self.contentView addSubview:bgView];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
//        imageView.backgroundColor = [UIColor grayColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"ic_plus"];
        [bgView addSubview:imageView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:13];
        label.text = [[LANGUAGE getStringForKey:@"insert_cup_size"] uppercaseString];
        label.backgroundColor = CLEAR_COLOR;
        label.numberOfLines = 99;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textColor = MAIN_COLOR;
        [bgView addSubview:label];
    }
    return self;
}

-(void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
    if (highlighted) {
        bgView.backgroundColor = MAIN_COLOR;
        label.textColor = [UIColor whiteColor];
    }
    else{
        bgView.backgroundColor = [UIColor whiteColor];;
        label.textColor = MAIN_COLOR;
    }
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self setNeedsDisplay];
    if (selected) {
        bgView.backgroundColor = MAIN_COLOR;
        label.textColor = [UIColor whiteColor];
    }
    else{
        bgView.backgroundColor = [UIColor whiteColor];;
        label.textColor = MAIN_COLOR;
    }
}


-(void)layoutSubviews{
    [super layoutSubviews];
    bgView.frame = self.contentView.bounds;
    imageView.frame = CGRectMake(10, 20, CGRectGetWidth(bgView.bounds) - 20, CGRectGetHeight(bgView.frame) - 80);
    label.frame  = CGRectMake(10, CGRectGetMaxY(imageView.frame)+5, CGRectGetWidth(bgView.bounds) - 20, 40);
    
}



@end
