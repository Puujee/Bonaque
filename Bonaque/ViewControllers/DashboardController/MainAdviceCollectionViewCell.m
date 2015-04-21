//
//  MainAdviceCollectionViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "MainAdviceCollectionViewCell.h"

@implementation MainAdviceCollectionViewCell
@synthesize item = _item;

-(void)setItem:(Advice *)item{
    _item = item;
//    _adviceImageView.backgroundColor = UIColorFromRGB(0xc3e1fb);
    _adviceImageView.image = [UIImage imageNamed:@"imd_advice_big"];
    _adviceDescriptionLabel.text = _item.content;
    _adviceTitleLabel.text = [LANGUAGE getStringForKey:@"today_advice"];
}

- (void)awakeFromNib {
    // Initialization code
    if ([UIScreen isiPhone6Plus] || [UIScreen isiPhone6]) {
        _adviceDescriptionLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:15];
    }
    [self.layer setCornerRadius:3];
    self.clipsToBounds = YES;
    
    _bgView.backgroundColor = MAIN_COLOR;
}

@end
