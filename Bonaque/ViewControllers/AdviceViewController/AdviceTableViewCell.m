//
//  AdviceTableViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AdviceTableViewCell.h"

@implementation AdviceTableViewCell

@synthesize item =_item;

-(void)setItem:(Advice *)item{
    _item = item;
    _adviceImageView.image = [UIImage imageNamed:_item.icon];
    _adviceTitleLabel.text = _item.title;
    _adviceDescLabel.text = _item.content;
}

- (void)awakeFromNib {
    // Initialization code
    [_adviceImageView.layer setCornerRadius:25];
    _adviceImageView.clipsToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    _shareButton.shareContent = content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
