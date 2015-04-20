//
//  CupCollectionViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "CupCollectionViewCell.h"

@interface CupCollectionViewCell (){
    UIView *bgView;
    UIImageView *imageView;
    UILabel *label;
    
    UIButton *cupButton;
}

@end

@implementation CupCollectionViewCell
@synthesize item = _item;

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
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.backgroundColor = MAIN_COLOR;
        [bgView addSubview:imageView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:20];
        label.text = @"";
        label.backgroundColor = CLEAR_COLOR;
        label.textColor = MAIN_COLOR;
        [bgView addSubview:label];
        
//        cupButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        cupButton.backgroundColor = [UIColor whiteColor];
//        [cupButton setBackgroundImage:[HXColor imageWithColor:MAIN_COLOR] forState:UIControlStateHighlighted];
//        [cupButton setBackgroundImage:[HXColor imageWithColor:MAIN_COLOR] forState:UIControlStateSelected];
//        [cupButton setImage:[UIImage imageNamed:@"cup"] forState:UIControlStateNormal];
//        cupButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        cupButton.frame = CGRectMake(0, 0, 0, 100);
//        cupButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
////        [cupButton addTarget:self action:@selector(selectCup:) forControlEvents:UIControlEventTouchUpInside];
////        cupButton.tag = 100 + item.id.intValue;
//        [cupButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
//        [cupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//        [cupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//        cupButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [bgView addSubview:cupButton];
    }
    return self;
}

-(void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
    if (highlighted) {
        bgView.backgroundColor = MAIN_COLOR;
        label.textColor = [UIColor whiteColor];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_clicked", _item.icon]];

    }
    else{
        bgView.backgroundColor = [UIColor whiteColor];;
        label.textColor = MAIN_COLOR;
        imageView.image = [UIImage imageNamed:_item.icon];
    }
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self setNeedsDisplay];
    if (selected) {
        bgView.backgroundColor = MAIN_COLOR;
        label.textColor = [UIColor whiteColor];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_clicked", _item.icon]];
    }
    else{
        bgView.backgroundColor = [UIColor whiteColor];;
        label.textColor = MAIN_COLOR;
        imageView.image = [UIImage imageNamed:_item.icon];
    }
}

-(void)setItem:(Cup *)item{
    _item = item;
    label.text =  [NSString stringWithFormat:@"%@ ml", item.ml];
    imageView.image = [UIImage imageNamed:_item.icon];
    [self setNeedsLayout];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    bgView.frame = self.contentView.bounds;
    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(bgView.bounds), CGRectGetHeight(bgView.frame)  - 15);
    if (_item.ml.intValue >= 330) {
        imageView.frame = CGRectMake(0, 10, CGRectGetWidth(bgView.bounds), CGRectGetHeight(bgView.frame)  - 45);
    }
    else if (_item.ml.intValue == 500){
        imageView.frame = CGRectMake(0, 10, CGRectGetWidth(bgView.bounds), CGRectGetHeight(bgView.frame)  - 35);
    }
    else if (_item.ml.intValue == 500){
        imageView.frame = CGRectMake(0, 10, CGRectGetWidth(bgView.bounds), CGRectGetHeight(bgView.frame)  - 25);
    }
    label.frame  = CGRectMake(10, CGRectGetHeight(bgView.frame) - 40, CGRectGetWidth(bgView.bounds) - 20, 20);
}

@end
