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
    float titleWidth;
    float contentWidth;
    float fontSize;
    float titleFontSize;
    float chartTitleFontSize;
    float chartDescFontSize;
    
    float chartsWidth;
    float normalWidth;
    float buttonHeight;
    
    float rightMargin;
    float leftMargin;
    float topMargin;
    float botMargin;
    
    float mansHeight;
    float mansWidth;
    
    float titleBotMargin;
    float titleTopMargin;
}

@property (nonatomic) PNPieChart *pieChart;
@end

@implementation MainCollectionViewCell
@synthesize delegate;

- (void)awakeFromNib {
    titleHeight = 22;
    titleWidth = 120;
    contentWidth = 87;
    fontSize = 16;
    titleFontSize = 14;
    
    
    chartTitleFontSize = 28;
    chartDescFontSize = 11;
    
    buttonHeight = 60;
    
    normalWidth = 140;
    rightMargin = 10;
    
    topMargin = 15;
    titleTopMargin = 15;
    botMargin = 10;
    leftMargin = 10;

    
    mansHeight = 200;
    titleBotMargin = 35;

    if ([UIScreen isiPhone5]) {
        titleHeight = 25;
        titleWidth = 120;
        contentWidth = 80;
        fontSize = 16;
        titleFontSize = 14;
        
        
        chartTitleFontSize = 30;
        chartDescFontSize = 13;
        
        buttonHeight = 70;
        
        normalWidth = 140;
        rightMargin = 10;
        
        topMargin = 20;
        titleTopMargin = 25;
        leftMargin = 0;
        botMargin = 17;
        
        mansHeight = 250;
        titleBotMargin = 45;
    }
    else if ([UIScreen isiPhone6]){
        titleHeight = 26;
        titleWidth = 130;
        contentWidth = 97;
        fontSize = 18;
        titleFontSize = 16;
        
        
        chartTitleFontSize = 32;
        chartDescFontSize = 15;
        
        buttonHeight = 80;
        
        normalWidth = 170;
        rightMargin = 10;
        
        topMargin = 20;
        titleTopMargin = 25;
        leftMargin = 0;
        botMargin = 27;
        
        titleBotMargin = 50;
        
        rightMargin = 20;
        
        mansHeight = 300;
    }
    else if ([UIScreen isiPhone6Plus]){
        titleHeight = 35;
        titleWidth = 140;
        contentWidth = 97;
        fontSize = 18;
        titleFontSize = 18;
        
        chartTitleFontSize = 32;
        chartDescFontSize = 15;
        
        buttonHeight = 90;
        
        normalWidth = 180;
        rightMargin = 10;
        
        topMargin = 25;
        titleTopMargin = 35;
        leftMargin = 0;
        botMargin = 28;
        
        mansHeight = 250;
        titleBotMargin = 65;
        
        rightMargin = 20;
        
        mansHeight = 330;
    }
    chartsWidth = normalWidth;
    mansWidth = mansHeight/16*9;

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

    float fullHeight = mansHeight;
    float currentHeight = (fullHeight*lastItem.currentWaterPercent.floatValue)/ 100;
//    float currentHeight = (fullHeight*100)/ 100;
    [UIView animateWithDuration:1.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect rect = _percentMaskedView.frame;
        rect.origin.y = mansHeight - currentHeight;
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
    {
        CGRect rect = _maskedImagesBgView.frame;
        rect.origin.x = leftMargin;
        rect.origin.y  = topMargin;
        rect.size.height = mansHeight;
        rect.size.width = mansWidth;
        _maskedImagesBgView.frame= rect;
        
        _maskedImage.frame = _maskedImagesBgView.bounds;
    }
    _firstTitleLabel.frame = CGRectMake(rightMargin, CGRectGetHeight(self.frame) - titleBotMargin, titleWidth, titleHeight);
    _firstContentLabel.frame = CGRectMake(CGRectGetMaxX(_firstTitleLabel.frame), CGRectGetMinY(_firstTitleLabel.frame), contentWidth, titleHeight);
    
    _secondTitleLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - titleWidth - contentWidth + 10, titleTopMargin, titleWidth, titleHeight);
    _secondContentLabel.frame = CGRectMake(CGRectGetMaxX(_secondTitleLabel.frame) - 10, CGRectGetMinY(_secondTitleLabel.frame), contentWidth, titleHeight);
    
    _thirdTitleLabel.hidden = YES;
    _thirdContentLabel.hidden = YES;
//    _thirdTitleLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - titleWidth, CGRectGetMaxY(_secondContentLabel.frame) + margin, titleWidth, titleHeight);
//    _thirdContentLabel.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - contentWidth - (titleWidth - contentWidth)/2 , CGRectGetMaxY(_thirdTitleLabel.frame) + margin, contentWidth, titleHeight);
    
    if (!isFirst) {
        isFirst = YES;
        CGRect rect = _percentMaskedView.frame;
        rect.origin.x = 5;
        rect.size.width = mansWidth - 10;
        rect.origin.y = mansHeight;
        rect.size.height = 0 ;
        _percentMaskedView.frame = rect;
    }
//    [_addButton removeFromSuperview];
//    [_addButton setTranslatesAutoresizingMaskIntoConstraints:YES];
    _addButton.frame = CGRectMake(CGRectGetWidth(self.frame) - rightMargin - buttonHeight, CGRectGetHeight(self.frame) - buttonHeight - botMargin, buttonHeight, buttonHeight);
    [_addButton.layer setCornerRadius:buttonHeight/2];
    _addButton.clipsToBounds = YES;
    [_addButton setBackgroundImage:[HXColor imageWithColor:UIColorFromRGB(0x67be27)] forState:UIControlStateNormal];
//    [self addSubview:_addButton];
    
    CGRect chartRect = _chartView.frame;
    chartRect.size.height = chartsWidth;
    chartRect.size.width = chartsWidth;
    chartRect.origin.x = CGRectGetWidth(self.frame)- chartsWidth - rightMargin;
    chartRect.origin.y = (CGRectGetHeight(self.frame) - chartsWidth)/2 - rightMargin;
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
