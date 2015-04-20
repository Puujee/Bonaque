//
//  SettingsTableViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/5/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell
@synthesize item = _item;
@synthesize isChecked = _isChecked;
@synthesize disableMode = _disableMode;

- (void)setItem:(SettingsItem *)item{
    _item = item;
    _nameLabel.text = _item.title;
    _descLabel.text = _item.description;
    _checkLabel.hidden = YES;
    _checkboxImageView.hidden = YES;

    if (_item.itsHaveCheckBox) {
        _checkLabel.hidden = NO;
        _checkboxImageView.hidden = NO;
    }
    if (_item.description.length == 0) {
        CGRect rect = _nameLabel.frame;
        rect.origin.y    = 15;
        _nameLabel.frame = rect;
    }
    else{
        CGRect rect = _nameLabel.frame;
        rect.origin.y    = 5;
        _nameLabel.frame = rect;
    }

}

- (void)setIsChecked:(BOOL)isChecked{
    _isChecked = isChecked;
    if (isChecked) {
        _checkboxImageView.image = [UIImage imageNamed:@"ic_check_active"];
        _checkLabel.text = @"☑︎";
    }else{
        _checkboxImageView.image = [UIImage imageNamed:@"ic_check"];
        _checkLabel.text = @"◻︎";
    }
}

-(void)setDisableMode:(BOOL)disableMode{
    _disableMode = disableMode;
    if (_disableMode) {
        _nameLabel.textColor = [UIColor lightGrayColor];
        _descLabel.textColor = [UIColor lightGrayColor];
    }
    else{
        _nameLabel.textColor = [UIColor blackColor];
        _descLabel.textColor = [UIColor blackColor];
    }
}

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (_descLabel.text.length == 0) {
        CGRect rect = _nameLabel.frame;
        rect.origin.y    = 15;
        _nameLabel.frame = rect;
    }
    else{
        CGRect rect = _nameLabel.frame;
        rect.origin.y    = 5;
        _nameLabel.frame = rect;
    }
}

@end
