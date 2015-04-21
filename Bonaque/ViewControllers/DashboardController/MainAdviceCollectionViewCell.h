//
//  MainAdviceCollectionViewCell.h
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainAdviceCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *adviceImageView;
@property (weak, nonatomic) IBOutlet UILabel *adviceTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *adviceDescriptionLabel;
@property (nonatomic, strong) Advice *item;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
