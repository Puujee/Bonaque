//
//  ChartViewController.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "ChartViewController.h"
#import "PNBarChart.h"
#import "PNLineChart.h"
#import "PNLineChartData.h"
#import "PNLineChartDataItem.h"
#import "Barchart.h"
#import "LineChartsView.h"

@interface ChartViewController (){
    UIScrollView *scrollView;
    
    float maxValue;
    NSDate *lastDate;
    NSCalendar *gregorian;
    UILabel  *label;
    UIView *segmentContainerView;
    UISegmentedControl *segmentedControl;
    UIButton *rightBarButton;
    BOOL isLine;
    
    LineChartsView *lineCharts;
    Barchart *barCharts;
}
@property (nonatomic) PNBarChart * barChart;
@property (nonatomic) PNLineChart * lineChart;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    gregorian.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:9];
    
//    rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightBarButton setImage:[UIImage imageNamed:@"ic-chart-line"] forState:UIControlStateNormal];
//    //    [rightBarButton setTitle:@"Bar" forState:UIControlStateNormal];
//    rightBarButton.frame = CGRectMake(0, 0, 30, 30);
//    
//    [rightBarButton addTarget:self  action:@selector(changeChartMode:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *revealBarbutton = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
//    self.navigationItem.rightBarButtonItem = revealBarbutton;
    
    self.title = [[LANGUAGE getArrayForKey:@"menus"] objectAtIndex:1];
    
    scrollView  =[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    scrollView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    [self.view addSubview:scrollView];
    
    segmentContainerView = [[UIView alloc] initWithFrame:CGRectMake(10 , 10, CGRectGetWidth(self.view.frame) - 20, 35)];
    segmentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    segmentContainerView.backgroundColor = [UIColor whiteColor];
    [segmentContainerView.layer setCornerRadius:4];
    segmentContainerView.layer.shadowOpacity = 0.6;
    segmentContainerView.layer.shadowOffset = CGSizeMake(0, 0);
    segmentContainerView.layer.shadowRadius = 1;
    segmentContainerView.layer.masksToBounds = NO;
    {
        NSArray *itemArray = [NSArray arrayWithObjects: @"7 хоногоор", @"Сараар", nil];
        segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.backgroundColor = [UIColor clearColor];
        segmentedControl.frame = CGRectMake(0 , 0, CGRectGetWidth(self.view.frame) - 20, 35);
        [[UISegmentedControl appearance] setTintColor:MAIN_COLOR];
        segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [segmentedControl addTarget:self action:@selector(segmentIndexDidChange:) forControlEvents: UIControlEventValueChanged];
        segmentedControl.selectedSegmentIndex = 0;
        [segmentContainerView addSubview:segmentedControl];
    }
//    [scrollView addSubview:segmentContainerView];
    
    UIView *titleContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.view.frame) - 20, 50)];
    titleContainer.backgroundColor = [UIColor whiteColor];
    [titleContainer.layer setCornerRadius:4];
    titleContainer.clipsToBounds = YES;
    [scrollView addSubview:titleContainer];
    {
        label= [[UILabel alloc] initWithFrame:CGRectMake(70, 3, CGRectGetWidth(titleContainer.bounds) - 140, 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:18];
        label.text = [[LANGUAGE getStringForKey:@"chart1_title"] uppercaseString];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 99;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.textColor = [UIColor blackColor];
        [titleContainer addSubview:label];
        
        UIButton *prevButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        prevButton.frame = CGRectMake(10, 7, 60, 35);
        [prevButton setTitle:@"Өмнөх" forState:UIControlStateNormal];
        [prevButton setImage:[UIImage imageNamed:@"ic_graphic_prev"] forState:UIControlStateNormal];
        prevButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [prevButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [prevButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [prevButton addTarget:self action:@selector(prevBarChartButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [titleContainer addSubview:prevButton];
        
        UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        nextButton.frame = CGRectMake(CGRectGetMaxX(label.frame) + 5, 7, 60, 35);
        [nextButton setTitle:@"Дараах" forState:UIControlStateNormal];
        [nextButton setImage:[UIImage imageNamed:@"ic_graphic_next"] forState:UIControlStateNormal];
        [nextButton setImageEdgeInsets:UIEdgeInsetsMake(0, 50, 0, 0)];
        [nextButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        nextButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        nextButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [nextButton addTarget:self action:@selector(nextBarChartButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [titleContainer addSubview:nextButton];
    }
//    lineCharts = [[LineChartsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleContainer.frame), CGRectGetWidth(self.view.frame), 530)];
//    lineCharts.backgroundColor = [UIColor clearColor];
//    lineCharts.hidden = YES;
//    [scrollView addSubview:lineCharts];
    
    float height = 570;
    if ([UIScreen isiPhone5] || [UIScreen isiPhone4]) {
        height = 595;
    }
    
    barCharts    = [[Barchart alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleContainer.frame), CGRectGetWidth(self.view.frame), height)];
    barCharts.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:barCharts];
    
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(barCharts.frame) + 10);
    [self calculateTopChartData:[NSDate date]];
}


-(void)segmentIndexDidChange:(id)sender{
    [self calculateTopChartData:lastDate];
}



-(void)nextBarChartButtonPressed{
    NSDate *updatedLastDate;
    if (segmentedControl.selectedSegmentIndex == 0) {
        NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *comps = [[NSCalendar currentCalendar] components:units fromDate:lastDate];
        comps.day = comps.day + 7;
        updatedLastDate = [gregorian dateFromComponents:comps];
    }
    else{
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:lastDate];
        components.day = 1;
        if (components.month < 12) {
            components.month += 1;
        }
        else{
            components.month = 1;
            components.year +=1;
        }
        updatedLastDate = [gregorian dateFromComponents:components];
    }
    [self calculateTopChartData:updatedLastDate];
    
}

-(void)prevBarChartButtonPressed{
    NSDate *updatedLastDate;
    if (segmentedControl.selectedSegmentIndex == 0) {
        NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *comps = [[NSCalendar currentCalendar] components:units fromDate:lastDate];
        comps.day = comps.day - 7;
        updatedLastDate = [gregorian dateFromComponents:comps];
    }
    else{
        NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:lastDate];
        components.day = 1;
        if (components.month > 1) {
            components.month -= 1;
        }
        else{
            components.month = 12;
            components.year -=1;
        }
        updatedLastDate = [gregorian dateFromComponents:components];
    }
    [self calculateTopChartData:updatedLastDate];

}

-(void)setTitleLabel:(NSArray *)weekArray{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd";
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *labelText= [NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:[weekArray objectAtIndex:0] ], [dateFormatter stringFromDate:[weekArray lastObject]]];
    label.text = labelText;
}

-(void)calculateTopChartData:(NSDate *)date{
    lastDate = date;
    
    NSMutableArray *tempArray = [NSMutableArray array];
    NSMutableArray *weekTempArray = [NSMutableArray array];
    NSMutableArray *weightTempArray = [NSMutableArray array];
    NSMutableArray *colorTempArray = [NSMutableArray array];
    NSMutableArray *colorTempArray1 = [NSMutableArray array];


    NSArray *weekArray = [self daysThisWeek];
    BOOL isMonth = false;
    if (segmentedControl.selectedSegmentIndex == 0) {
        weekArray = [self daysThisWeek];
    }
    else{
        weekArray = [self daysThisMonth];
        isMonth = YES;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd";
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    int i = 0;
    for (NSDate *date in  weekArray) {
        PersonLog *item = [DATABASE getPersonLogWithDate:date];
        if (item) {
            [tempArray addObject:item.currentWaterLitre];
            if (item.currentWaterLitre.floatValue > maxValue) {
                maxValue = item.currentWaterLitre.floatValue;
                self.barChart.yMaxValue = maxValue;
            }
            [colorTempArray addObject:[self getColorFromCurrentWater:item]];
            [weightTempArray addObject:item.weight];
            [colorTempArray1 addObject:[self getColorFromCurrentWeight:item]];
        }
        else{
            [colorTempArray1 addObject:[UIColor whiteColor]];
            [colorTempArray addObject:[UIColor whiteColor]];
            [tempArray addObject:[NSNumber numberWithFloat:0]];
            [weightTempArray addObject:[NSNumber numberWithFloat:0]];
        }
        if (!isMonth) {
            [weekTempArray addObject:[NSString stringWithFormat:@"%@\n%@", [dateFormatter stringFromDate:date], [[LANGUAGE getArrayForKey:@"week_days"] objectAtIndex:i]]];
            if (i >= 6) {
                i = 0;
            }
            else{
                i++;
            }
        }
        else{
            [weekTempArray addObject:[NSString stringWithFormat:@"%@\n", [dateFormatter stringFromDate:date]]];
        }
    }
    
    if (isLine) {
        lineCharts.firstChartItems = @[tempArray, weekTempArray, colorTempArray, [NSNumber numberWithFloat:maxValue]];
        lineCharts.secondChartItems = @[weightTempArray, weekTempArray, colorTempArray1];
    }
    else{
        barCharts.firstChartItems = @[tempArray, weekTempArray, colorTempArray, [NSNumber numberWithFloat:maxValue]];
        barCharts.secondChartItems = @[weightTempArray, weekTempArray, colorTempArray1];
    }
    // holds 23:59:59 of last day in week.
}

-(UIColor *)getColorFromCurrentWater:(PersonLog *)water{
    
    float percent = (water.currentWaterLitre.floatValue * 100)/ water.waterGoal.floatValue;
   if (percent > 75){
        return UIColorFromRGB(0x62d60d);
    }
    else if (percent <= 75 && percent > 40){
        return UIColorFromRGB(0xffcc33);
    }
    else if (percent <= 40){
        return UIColorFromRGB(0xe85858);
    }
    return nil;
}

-(UIColor *)getColorFromCurrentWeight:(PersonLog *)water{
    
    if (water.weightBMI.intValue == 0) {
        return UIColorFromRGB(0x0db1a0);
    }
    else if (water.weightBMI.intValue == 1){
        return UIColorFromRGB(0x62d60d);
    }
    else if (water.weightBMI.intValue == 2){
        return UIColorFromRGB(0xffa200);
    }
    else if (water.weightBMI.intValue == 3){
        return UIColorFromRGB(0xea31a2);
    }
    return nil;
}

#pragma mark
#pragma mark GetWeek

-(NSArray*)daysThisWeek
{
    return  [self daysInWeek:0 fromDate:lastDate];
}

-(NSArray*)daysNextWeek
{
    return  [self daysInWeek:1 fromDate:[NSDate date]];
}
-(NSArray*)daysInWeek:(int)weekOffset fromDate:(NSDate*)date
{
        //ask for current week
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps=[gregorian components:NSWeekCalendarUnit|NSYearCalendarUnit fromDate:date];
    //create date on week start
    NSDate* weekstart=[gregorian dateFromComponents:comps];
    if (weekOffset>0) {
        NSDateComponents* moveWeeks=[[NSDateComponents alloc] init];
        moveWeeks.week = 1;
        weekstart=[gregorian dateByAddingComponents:moveWeeks toDate:weekstart options:0];
    }
    //add 7 days
    NSMutableArray* week=[NSMutableArray arrayWithCapacity:7];
    for (int i=1; i<=7; i++) {
        NSDateComponents *compsToAdd = [[NSDateComponents alloc] init];
        compsToAdd.day=i;
        NSDate *nextDate = [gregorian dateByAddingComponents:compsToAdd toDate:weekstart options:0];
        [week addObject:nextDate];
    }
    [self setTitleLabel:week];
    return [NSArray arrayWithArray:week];
}

#pragma mark
#pragma mark GetMonth

-(NSArray*)daysThisMonth
{
    return  [self daysInMonth:0 fromDate:lastDate];
}

-(NSArray*)daysNexMonth
{
    return  [self daysInMonth:1 fromDate:[NSDate date]];
}
-(NSArray*)daysInMonth:(int)weekOffset fromDate:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy оны MM сар"];
    NSString *labelText= [NSString stringWithFormat:@"%@", [format stringFromDate:lastDate]];
    label.text = labelText;
    
    NSDateComponents *components = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:lastDate];
    //    _selectedDate  =components.day;
    components.day = 1;
//    NSDate *firstDayOfMonth = [gregorian dateFromComponents:components];
//    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:firstDayOfMonth];
    
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:lastDate];
    
    
    NSInteger monthLength = days.length;
    NSMutableArray* month=[NSMutableArray arrayWithCapacity:monthLength];
    NSDateComponents *componentsz = [gregorian components:(NSEraCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:lastDate];
    componentsz.day = 1;
    NSDate *datez = [gregorian dateFromComponents:componentsz];
    for (int i = 0; i < monthLength; i++) {
        NSDateComponents *compsToAdd = [[NSDateComponents alloc] init];
        compsToAdd.day = i + 1;
        NSDate *nextDate = [gregorian dateByAddingComponents:compsToAdd toDate:datez options:0];
        [month addObject:nextDate];
    }
    return month;
}

-(void)changeChartMode:(id)sender{
    if (!isLine) {
        isLine = YES;
        [rightBarButton setImage:[UIImage imageNamed:@"ic-chart-bar"] forState:UIControlStateNormal];
        barCharts.hidden = YES;
        lineCharts.hidden = NO;
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(lineCharts.frame) + 10);
    }
    else{
        isLine = NO;
        lineCharts.hidden = YES;
        [rightBarButton setImage:[UIImage imageNamed:@"ic-chart-line"] forState:UIControlStateNormal];
        barCharts.hidden = NO;
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(barCharts.frame) + 10);
    }
    [self calculateTopChartData:lastDate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
