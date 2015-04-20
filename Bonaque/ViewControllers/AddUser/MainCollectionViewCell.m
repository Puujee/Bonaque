//
//  MainCollectionViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/13/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "MainCollectionViewCell.h"

@interface MainCollectionViewCell (){
    
    BOOL isFirst;
    
    float titleHeight;
    float contentHeight;
    float fontSize;
    float titleFontSize;
    float chartTitleFontSize;
    float chartDescFontSize;
    float buttonHeight;
    
    float progressHeight;
    float progresTopMargin;
    float chartsWidth;
    float normalWidth;
    
    float rightMargin;
    float margin;
    float topMargin;
    float titleWidth;
    float contentWidth;
    float botMargin;
}

@property (nonatomic) PNPieChart *pieChart;
@end

@implementation MainCollectionViewCell
@synthesize delegate;

- (void)awakeFromNib {
    progressHeight = 236;
    progresTopMargin = 246;
    
    titleHeight = 18;
    contentHeight = 20;
    fontSize = 14;
    titleFontSize = 12;
    chartTitleFontSize = 28;
    chartDescFontSize = 11;
    buttonHeight = 40;
    normalWidth = 75;
    rightMargin = 25;
    
    topMargin = 3;
    botMargin = 5;
    margin = 3;
    titleWidth = 100;
    contentWidth = 77;
    

    if ([UIScreen isiPhone5]) {
        normalWidth = 85;
        progressHeight = 252;
        progresTopMargin = 283;
        margin = 5;
        topMargin = 10;
        buttonHeight = 55;
        
        titleHeight = 20;
        contentHeight = 22;
        fontSize = 16;
        titleFontSize = 14;
        chartTitleFontSize = 30;
        chartDescFontSize = 13;
        rightMargin = 25;
        titleWidth = 120;
        contentWidth = 87;
    }
    else if ([UIScreen isiPhone6]){
        normalWidth = 115;
        progressHeight = 349;
        progresTopMargin = 364;
        
        margin = 5;
        topMargin = 10;
        buttonHeight = 60;
        
        titleHeight = 26;
        contentHeight = 28;
        fontSize = 18;
        titleFontSize = 16;
        chartTitleFontSize = 32;
        chartDescFontSize = 15;
        rightMargin = 30;
        titleWidth = 140;
        contentWidth = 97;
    }
    else if ([UIScreen isiPhone6Plus]){
        normalWidth = 130;
        progressHeight = 339;
        progresTopMargin = 381;
        
        margin = 5;
        topMargin = 20;
        buttonHeight = 65;
        
        titleHeight = 26;
        contentHeight = 28;
        fontSize = 18;
        titleFontSize = 16;
        chartTitleFontSize = 32;
        chartDescFontSize = 15;
        rightMargin = 30;
        titleWidth = 140;
        contentWidth = 97;
        
        botMargin = 25;
    }
    chartsWidth = normalWidth;

    [self.layer setCornerRadius:3];
    self.clipsToBounds = YES;
    
    [self loadLabeslConstant];
    
    Person *user = [DATABASE getUser];
    if (user.gender.intValue == 1) {
        _maskedImage.image = [UIImage imageNamed:@"man_new"];
    }
    else{
        _maskedImage.image = [UIImage imageNamed:@"woman_new"];
    }
    ATLog(@"%@", _maskedImage.image);
}

-(void)updateDatas{
    PersonLog *lastItem = [DATABASE getTodaysPersonLog];
    _thirdContentLabel.text =  [NSString stringWithFormat:@"%.1f%%", lastItem.currentWaterPercent.floatValue ];
    _firstContentLabel.text = [NSString stringWithFormat:@"%.1f %@", lastItem.waterGoal.floatValue/ML, [LANGUAGE getStringForKey:@"litre"]];
    _currentLitreLabel.text  = [NSString stringWithFormat:@"%.1f", lastItem.currentWaterLitre.floatValue/ML];
    _litreLabel.text =  [[LANGUAGE getStringForKey:@"litre"] uppercaseString];
    
    Person *user = [DATABASE getUser];
    _secondTitleLabel.text = @"Биеийн жин";
    _secondContentLabel.text = [NSString stringWithFormat:@"%@ кг", user.weight];
    
    [self setNeedsLayout];
}



-(void)layoutSubviews{
    [super layoutSubviews];

    PersonLog *lastItem = [DATABASE getTodaysPersonLog];
    float diff = lastItem.waterGoal.floatValue - lastItem.currentWaterLitre.floatValue;
    if (diff < 0) {
        diff = 0;
    }

    NSArray *items = @[[PNPieChartDataItem dataItemWithValue:diff color:UIColorFromRGB(0xc3e1fb)],
                       [PNPieChartDataItem dataItemWithValue:lastItem.currentWaterLitre.floatValue color:UIColorFromRGB(0x03a9f4) description:@""],
                       ];
    
    [self.pieChart removeFromSuperview];
    
    self.pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, chartsWidth, chartsWidth) items:items];
    self.pieChart.descriptionTextColor = [UIColor clearColor];
    self.pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:11.0];
    self.pieChart.descriptionTextShadowColor = [UIColor clearColor];
    self.pieChart.showAbsoluteValues = NO;
    self.pieChart.showOnlyValues = NO;

    [_chartView addSubview:self.pieChart];
    [self.pieChart strokeChart];
    
    [self calculateFrames];

    float fullHeight = progressHeight;
    float currentHeight = (fullHeight*lastItem.currentWaterPercent.floatValue)/ 100;
//    float currentHeight = (fullHeight*100)/ 100;
    [UIView animateWithDuration:1.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect = _percentMaskedView.frame;
        rect.origin.y = progresTopMargin - currentHeight;
        rect.size.height = currentHeight;
        _percentMaskedView.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
    
    int lastDrinked = (int)[USERDEF integerForKey:kLAST_DRINKED_ML];
    if (lastDrinked > 0) {
        [_decreaseButton setImage:[UIImage imageNamed:@"ic-remove"] forState:UIControlStateNormal];
    }
    else{
        [_decreaseButton setImage:[UIImage imageNamed:@"ic_empty_inactive"] forState:UIControlStateNormal];
    }
 }


-(void)calculateFrames{
    _firstTitleLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - titleWidth, topMargin, titleWidth, titleHeight);
    _firstContentLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - contentWidth - (titleWidth - contentWidth)/2 , CGRectGetMaxY(_firstTitleLabel.frame) + margin, contentWidth, titleHeight);
    
    _secondTitleLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - titleWidth, CGRectGetMaxY(_firstContentLabel.frame) + margin, titleWidth, titleHeight);
    _secondContentLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - contentWidth  - (titleWidth - contentWidth)/2, CGRectGetMaxY(_secondTitleLabel.frame) + margin, contentWidth, titleHeight);
    
    _thirdTitleLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - titleWidth, CGRectGetMaxY(_secondContentLabel.frame) + margin, titleWidth, titleHeight);
    _thirdContentLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - contentWidth - (titleWidth - contentWidth)/2 , CGRectGetMaxY(_thirdTitleLabel.frame) + margin, contentWidth, titleHeight);
    
    if (!isFirst) {
        isFirst = YES;
        CGRect rect = _percentMaskedView.frame;
        rect.origin.y = progresTopMargin;
        rect.size.height = 0 ;
        _percentMaskedView.frame = rect;
      
        
        
//        [_decreaseButton removeFromSuperview];
//        [_decreaseButton setTranslatesAutoresizingMaskIntoConstraints:YES];
//        _decreaseButton.frame = CGRectMake(CGRectGetMinX(_addButton.frame) - rightMargin/3 - buttonHeight, CGRectGetHeight(self.frame) - buttonHeight - botMargin, buttonHeight, buttonHeight);
//        [self addSubview:_decreaseButton];
        
    }
//    [_addButton removeFromSuperview];
//    [_addButton setTranslatesAutoresizingMaskIntoConstraints:YES];
    _addButton.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - buttonHeight, CGRectGetHeight(self.frame) - buttonHeight - botMargin, buttonHeight, buttonHeight);
//    [self addSubview:_addButton];
    
    ATLog(@"%@", _addButton.frame);
    
    CGRect chartRect = _chartView.frame;
    chartRect.size.height = chartsWidth;
    chartRect.size.width = chartsWidth;
    chartRect.origin.x = CGRectGetWidth(self.frame)- chartsWidth - rightMargin - (titleWidth - chartsWidth)/2;
    chartRect.origin.y = CGRectGetMaxY(_thirdContentLabel.frame) + margin *2;
    _chartView.frame = chartRect;
    
    CGRect currentLitreRect = _currentLitreLabel.frame;
    currentLitreRect.size.width = chartsWidth ;
    _currentLitreLabel.frame = currentLitreRect;
    _currentLitreLabel.center = CGPointMake(CGRectGetMidX(_chartView.frame), _chartView.center.y - 10);
    
    CGRect litreRect = _litreLabel.frame;
    litreRect.size.width = chartsWidth ;
    _litreLabel.frame = litreRect;
    _litreLabel.center = CGPointMake(CGRectGetMidX(_chartView.frame), _chartView.center.y + 12);
    

}

-(void)loadLabeslConstant{
    {
        _firstTitleLabel.text = [LANGUAGE getStringForKey:@"todays_target"];
        _firstTitleLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:titleFontSize];
        _firstTitleLabel.textColor = UIColorFromRGB(0xffc107);
        
        [_firstContentLabel.layer setCornerRadius:3];
        _firstContentLabel.clipsToBounds = YES;
        _firstContentLabel.backgroundColor = UIColorFromRGB(0xffc107);
        _firstContentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
    }
    {
        _secondTitleLabel.text = @"Биеийн жин";
        _secondTitleLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:titleFontSize];
        _secondTitleLabel.textColor = UIColorFromRGB(0xff8400);
        
        [_secondContentLabel.layer setCornerRadius:3];
        _secondContentLabel.clipsToBounds = YES;
        _secondContentLabel.backgroundColor = UIColorFromRGB(0xff8400);
        _secondContentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
    }
    {
        _thirdTitleLabel.text = @"Биелэлт";
        _thirdTitleLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:titleFontSize];
        _thirdTitleLabel.textColor = UIColorFromRGB(0x67be27);
        
        [_thirdContentLabel.layer setCornerRadius:3];
        _thirdContentLabel.clipsToBounds = YES;
        _thirdContentLabel.backgroundColor = UIColorFromRGB(0x67be27);
        _thirdContentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
    }

//    _percentTitleLabel.text = [LANGUAGE getStringForKey:@"completion"];
//    _percentTitleLabel.textColor = [UIColor blackColor];
//    _percentMaskedView.backgroundColor = UIColorFromRGB(0xffc107);
}

- (IBAction)removeButtonClicked:(id)sender {
    int lastDrinked = (int)[USERDEF integerForKey:kLAST_DRINKED_ML];
    if (lastDrinked > 0) {
        [USERDEF setInteger:0 forKey:kLAST_DRINKED_ML];
        PersonLog *lastLog = [DATABASE getTodaysPersonLog];
        
        float currentSize = lastLog.currentWaterLitre.floatValue - lastDrinked;
        float dailyGoal = lastLog.waterGoal.floatValue ;
        float percent = currentSize/(dailyGoal/100);
        lastLog.currentWaterLitre = [NSNumber numberWithFloat:currentSize];
        lastLog.currentWaterPercent = [NSNumber numberWithFloat:percent];
        NSError *error = nil;
        if (![DATABASE.personLogFetchedResultController   performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [DATABASE saveChanges];
        [_decreaseButton setImage:[UIImage imageNamed:@"ic_empty_inactive"] forState:UIControlStateNormal];
        [self updateDatas];
    }
}

- (IBAction)addButtonClicked:(id)sender {
    [delegate addCupsClicked];
}
@end
