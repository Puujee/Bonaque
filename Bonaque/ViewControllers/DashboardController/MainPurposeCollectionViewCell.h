//
//  MainPurposeCollectionViewCell.h
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPurposeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *purposeImageView;
@property (weak, nonatomic) IBOutlet UILabel *purposeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *purposeContentView;

@property (weak, nonatomic) IBOutlet UIView *purposImageBgView;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;


@end
