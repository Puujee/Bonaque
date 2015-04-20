//
//  MainCollectionViewCell.h
//  Bonaque
//
//  Created by Puujee on 4/13/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChartDelegate.h"
#import "PNChart.h"
#import "CircleProgressView.h"

@protocol MainCollectionViewCellDelegate <NSObject>

-(void)addCupsClicked;

@end

@interface MainCollectionViewCell : UICollectionViewCell
{
    id<MainCollectionViewCellDelegate>delegate;
}
@property (strong, nonatomic) id<MainCollectionViewCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIView *maskedImagesBgView;
@property (weak, nonatomic) IBOutlet UIView *percentMaskedView;
@property (weak, nonatomic) IBOutlet UIImageView *maskedImage;
@property (weak, nonatomic) IBOutlet UIView *chartView;
@property (weak, nonatomic) IBOutlet UILabel *currentLitreLabel;

-(void)updateDatas;
- (IBAction)removeButtonClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *firstTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstContentLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondContentLabel;

@property (weak, nonatomic) IBOutlet UILabel *thirdTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdContentLabel;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *decreaseButton;

@property (weak, nonatomic) IBOutlet UILabel *litreLabel;
- (IBAction)addButtonClicked:(id)sender;


@end
