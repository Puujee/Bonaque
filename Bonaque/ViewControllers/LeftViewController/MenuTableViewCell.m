//
//  MenuTableViewCell.m
//  Bondooloi
//
//  Created by Puujee on 10/30/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

@synthesize item = _item;

-(void)setItem:(MenuItem *)item{
    _item = item;
    _titleLabel.text = _item.title;
    _logoImageView.image = [UIImage imageNamed:_item.imageName];
//    _logoImageView.highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected", _item.imageName]];
}

- (void)awakeFromNib {
    // Initialization code
    [_badgeView.layer setCornerRadius:5];
    _badgeView.clipsToBounds = YES;
    self.backgroundColor = CLEAR_COLOR;
    self.backgroundView.backgroundColor = CLEAR_COLOR;
    self.selectedBackgroundView.backgroundColor = CLEAR_COLOR;
    self.contentView.backgroundColor = CLEAR_COLOR;
    self.backgroundView.alpha    = 0;
    self.selectedBackgroundView.alpha = 0;
    _bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    _bgView.backgroundColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    self.backgroundView.alpha    = 0;
    self.selectedBackgroundView.alpha = 0;
    if (selected) {
        _bgView.backgroundColor = MAIN_COLOR;
        self.contentView.backgroundColor = MAIN_COLOR;
    }
    else{
        _bgView.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];

    }
}

@end
