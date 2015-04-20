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
    [self.layer setCornerRadius:3];
    self.clipsToBounds = YES;
}

@end
