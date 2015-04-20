//
//  MenuTableViewCell.h
//  Bondooloi
//
//  Created by Puujee on 10/30/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

/*!
 * @brief Зүүн menu-н үндсэн Cell
 */


@interface MenuTableViewCell : UITableViewCell

@property (nonatomic, strong) MenuItem *item;

@property (weak, nonatomic) IBOutlet UIView *badgeView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
