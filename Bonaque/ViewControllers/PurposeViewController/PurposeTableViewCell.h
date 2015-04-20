//
//  PurposeTableViewCell.h
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurposeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *purposeImageView;
@property (weak, nonatomic) IBOutlet UIView *topLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UILabel *purposeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *purposeDescription;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@property (nonatomic, assign) BOOL isLast;
@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, strong) Purpose *item;

@end
