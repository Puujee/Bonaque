//
//  SettingsTableViewCell.h
//  Bonaque
//
//  Created by Puujee on 4/5/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsItem.h"

@interface SettingsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxImageView;

@property (assign, nonatomic) BOOL isChecked;
@property (assign, nonatomic) BOOL disableMode;

@property (strong, nonatomic) SettingsItem *item;

@end
