//
//  LineChartsView.m
//  Bonaque
//
//  Created by Puujee on 4/20/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "LineChartsView.h"
#import "PNBarChart.h"
#import "PNLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"

@interface LineChartsView ()

@property (nonatomic, strong) PNLineChart *firstLineChart;
@property (nonatomic, strong) PNLineChart *secondLineChart;

@end

@implementation LineChartsView

@synthesize firstChartItems = _firstChartItems;
@synthesize secondChartItems = _secondChartItems;

-(id)initWithFrame:(CGRect)frame    {
    self= [super initWithFrame:frame];
    if (self) {
        UIView *topChartContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.frame) - 20, 250)];
        topChartContainer.backgroundColor = [UIColor whiteColor];
        [topChartContainer.layer setCornerRadius:4];
        topChartContainer.clipsToBounds = YES;
        [self addSubview:topChartContainer];
        Person *user = [DATABASE getUser];
        PersonLog *log = [DATABASE getTodaysPersonLog];
        {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, CGRectGetHeight(topChartContainer.frame), 20)];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
            titleLabel.backgroundColor = CLEAR_COLOR;
            titleLabel.numberOfLines = 99;
            titleLabel.text = @"УСНЫ ГРАФИК";
            titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            titleLabel.textColor = MAIN_COLOR;
            [topChartContainer addSubview:titleLabel];
            
            UILabel *yLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(-115, 60, CGRectGetHeight(topChartContainer.frame), 20)];
            yLabelTitle.textAlignment = NSTextAlignmentLeft;
            yLabelTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            yLabelTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
            yLabelTitle.backgroundColor = CLEAR_COLOR;
            yLabelTitle.numberOfLines = 99;
            yLabelTitle.transform  =  CGAffineTransformMakeRotation(M_PI/2 *3);
            yLabelTitle.text = @"өдөрт уусан усны хэмжээ(литр)";
            yLabelTitle.lineBreakMode = NSLineBreakByWordWrapping;
            yLabelTitle.textColor = [UIColor lightGrayColor];
            [topChartContainer addSubview:yLabelTitle];
            
            
            self.firstLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(15, 40, CGRectGetWidth(topChartContainer.frame)- 20, 200.0)];
            self.firstLineChart.yLabelFormat = @"%1.f";
//            [self.firstLineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
            self.firstLineChart.yFixedValueMax = log.waterGoal.floatValue;
            self.firstLineChart.yFixedValueMin = 0;
            self.firstLineChart.showLabel  = YES;
            self.firstLineChart.backgroundColor = [UIColor clearColor];
            self.firstLineChart.showCoordinateAxis = YES;
            self.firstLineChart.yLabelFont = [UIFont fontWithName:MAIN_LIGHT_FONT size:11];
            self.firstLineChart.xLabelFont = [UIFont fontWithName:MAIN_LIGHT_FONT size:11];
            [topChartContainer addSubview:self.firstLineChart];
            
            self.firstLineChart.legendStyle = PNLegendItemStyleStacked;
            self.firstLineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
            self.firstLineChart.legendFontColor = [UIColor redColor];
            
            UIView *legend = [self.firstLineChart getLegendWithMaxWidth:320];
            [legend setFrame:CGRectMake(30, 240, legend.frame.size.width, legend.frame.size.width)];
            [topChartContainer addSubview:legend];
        }
        
        UIView *bottomChartContainer = [[UIView alloc] initWithFrame:CGRectMake(10,  CGRectGetMaxY(topChartContainer.frame) + 10, CGRectGetWidth(self.frame) - 20, 250)];
        bottomChartContainer.backgroundColor = [UIColor whiteColor];
        [bottomChartContainer.layer setCornerRadius:4];
        bottomChartContainer.clipsToBounds = YES;
        [self addSubview:bottomChartContainer];
        
        {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetHeight(topChartContainer.frame), 20)];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
            titleLabel.backgroundColor = CLEAR_COLOR;
            titleLabel.numberOfLines = 99;
            titleLabel.text = @"ЖИНГИЙН ГРАФИК";
            titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            titleLabel.textColor = MAIN_COLOR;
            [bottomChartContainer addSubview:titleLabel];
            
            UILabel *yLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(-115, 40, CGRectGetHeight(topChartContainer.frame), 20)];
            yLabelTitle.textAlignment = NSTextAlignmentLeft;
            yLabelTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            yLabelTitle.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
            yLabelTitle.backgroundColor = CLEAR_COLOR;
            yLabelTitle.numberOfLines = 99;
            yLabelTitle.transform  =  CGAffineTransformMakeRotation(M_PI/2 *3);
            yLabelTitle.text = @"таны биеийн жин(кг)";
            yLabelTitle.lineBreakMode = NSLineBreakByWordWrapping;
            yLabelTitle.textColor = [UIColor lightGrayColor];
            [bottomChartContainer addSubview:yLabelTitle];
            
            self.secondLineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(15, 40, CGRectGetWidth(bottomChartContainer.frame)-20, 200.0)];
            self.secondLineChart.yLabelFormat = @"%1.f";
//            [self.secondLineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
            self.secondLineChart.backgroundColor = [UIColor clearColor];
            self.secondLineChart.showCoordinateAxis = YES;
            self.secondLineChart.yFixedValueMax = user.weight.floatValue + 30;
            self.secondLineChart.yFixedValueMin = user.weight.floatValue - 30;
            self.secondLineChart.xLabelFont = [UIFont fontWithName:MAIN_LIGHT_FONT size:11];
            self.secondLineChart.yLabelFont = [UIFont fontWithName:MAIN_LIGHT_FONT size:11];
            [bottomChartContainer addSubview:self.secondLineChart];
            
            self.secondLineChart.legendStyle = PNLegendItemStyleStacked;
            self.secondLineChart.legendFont = [UIFont boldSystemFontOfSize:12.0f];
            self.secondLineChart.legendFontColor = [UIColor redColor];
            
            UIView *legend = [self.secondLineChart getLegendWithMaxWidth:320];
            [legend setFrame:CGRectMake(30, 240, legend.frame.size.width, legend.frame.size.width)];
            [bottomChartContainer addSubview:legend];
        }
    }
    return self;
}

-(void)setFirstChartItems:(NSArray *)firstChartItems{
    _firstChartItems = firstChartItems;
    
    NSArray *weightTempArray = [_firstChartItems objectAtIndex:0];
    NSArray *weekTempArray = [_firstChartItems objectAtIndex:1];
    NSArray *colorTempArray = [_firstChartItems objectAtIndex:2];
    
//    float maxValue = [[_firstChartItems objectAtIndex:3] floatValue];
    
    NSArray * data01Array = weightTempArray;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = [LANGUAGE getStringForKey:@"weight"];
    data01.color = MAIN_COLOR;
    data01.alpha = 0.7f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        UIColor *color = colorTempArray[index];
        return [PNLineChartDataItem dataItemWithY:yValue withColor:color];
    };

    self.firstLineChart.chartData = @[data01];
    [self.firstLineChart setXLabels:weekTempArray];
    [self.firstLineChart updateChartData:@[data01]];
    [self.firstLineChart strokeChart];
}

-(void)setSecondChartItems:(NSArray *)secondChartItems{
    _secondChartItems = secondChartItems;
    
    NSArray *weightTempArray = [_secondChartItems objectAtIndex:0];
    NSArray *weekTempArray = [_secondChartItems objectAtIndex:1];
    NSArray *colorTempArray = [_secondChartItems objectAtIndex:2];
    
    NSArray * data01Array = weightTempArray;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.dataTitle = [LANGUAGE getStringForKey:@"weight"];
    data01.color = MAIN_COLOR;
    data01.alpha = 0.7f;
    data01.itemCount = data01Array.count;
    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        UIColor *color = colorTempArray[index];
        return [PNLineChartDataItem dataItemWithY:yValue withColor:color];
    };
    
    self.secondLineChart.chartData = @[data01];
    [self.secondLineChart setXLabels:weekTempArray];
    [self.secondLineChart updateChartData:@[data01]];
    [self.secondLineChart strokeChart];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
