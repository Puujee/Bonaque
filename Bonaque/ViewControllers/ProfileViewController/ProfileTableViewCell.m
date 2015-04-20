//
//  ProfileTableViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/15/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "ProfileTableViewCell.h"

@implementation ProfileTableViewCell

@synthesize item = _item;


-(void)setItem:(ProfileItem *)item{
    _item = item;
    _profileTitleLabel.textColor = _item.colour;
    _profileTitleLabel.text = _item.title;
    _profileDescriptionLabel.text = _item.desc;
    _profileImageView.image = [UIImage imageNamed:_item.icon];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
