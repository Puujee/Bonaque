//
//  ProfileTableViewCell.h
//  Bonaque
//
//  Created by Puujee on 4/15/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileItem.h"

@interface ProfileTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileDescriptionLabel;

@property (strong, nonatomic) ProfileItem *item;

@end
