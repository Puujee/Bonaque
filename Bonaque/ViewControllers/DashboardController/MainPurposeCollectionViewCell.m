//
//  MainPurposeCollectionViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "MainPurposeCollectionViewCell.h"

@interface MainPurposeCollectionViewCell (){
    BOOL isFirstTime;
}

@end

@implementation MainPurposeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.layer setCornerRadius:3];
    self.clipsToBounds = YES;
    _purposImageBgView.backgroundColor = MAIN_COLOR;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    PurposeLog *lastLog = [[[DATABASE purposeLogFetchedResultController] fetchedObjects] lastObject];
    Purpose *item = [DATABASE getPurposeID:lastLog.purposeLogID.intValue];
    _purposeTitleLabel.text = item.title;
//    _purposeImageView.frame = CGRectMake((CGRectGetWidth(_purposImageBgView.frame) - CGRectGetHeight(_purposeImageView.frame) + 20)/2, 10, CGRectGetHeight(_purposeImageView.frame) - 20, CGRectGetHeight(_purposeImageView.frame) - 20);
//    [_purposeImageView.layer setCornerRadius:CGRectGetHeight(_purposeImageView.frame)/2 + 10];

//    _purposeContentView.text =  [NSString stringWithFormat:@"%@ %@", lastLog.daysRemaining , [LANGUAGE getStringForKey:@"days_remaining"]];
    _countdownLabel.text = [NSString stringWithFormat:@"%@", lastLog.daysRemaining ];
//    float margin = 20;
//    if ([UIScreen isiPhone4]) {
//        margin = 5;
//    }
//    else if ([UIScreen isiPhone5]){
//        margin = 5;
//    }
//    CGRect rect = _purposImageBgView.frame;
//    rect.origin.y = margin;
//    rect.size.height = rect.size.height - margin*2;
//    _purposeImageView.frame = rect;
//    _purposeImageView.center = _purposImageBgView.center;
    
    if ([UIScreen isiPhone6Plus] || [UIScreen isiPhone6]) {
        _purposeContentView.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:15];
        _countdownLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:40];
    }
    
    _purposeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_achived", item.icon]];

}

@end
