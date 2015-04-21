//
//  Barchart.m
//  Bonaque
//
//  Created by Puujee on 4/20/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "Barchart.h"
#import "PNBarChart.h"


@interface Barchart (){
    
}

@property (nonatomic, strong) PNBarChart *firstBarChart;
@property (nonatomic, strong) PNBarChart *secondBarChart;

@end

@implementation Barchart

-(id)initWithFrame:(CGRect)frame    {
    self= [super initWithFrame:frame];
    if (self) {
        UIView *topChartContainer = [[UIView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.frame) - 20, 270)];
        topChartContainer.backgroundColor = [UIColor whiteColor];
        [topChartContainer.layer setCornerRadius:4];
        topChartContainer.clipsToBounds = YES;
        [self addSubview:topChartContainer];
//        Person *user = [DATABASE getUser];
        PersonLog *log = [DATABASE getTodaysPersonLog];
        {
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, CGRectGetHeight(topChartContainer.frame), 20)];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
            titleLabel.backgroundColor = CLEAR_COLOR;
            titleLabel.numberOfLines = 99;
            titleLabel.text = @"УСНЫ ХЭРЭГЛЭЭ";
            titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            titleLabel.textColor = MAIN_COLOR;
            [topChartContainer addSubview:titleLabel];
            
            UILabel *yLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(-120, 60, CGRectGetHeight(topChartContainer.frame), 20)];
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
            
            self.firstBarChart = [[PNBarChart alloc] initWithFrame:CGRectMake(25, 40, CGRectGetWidth(topChartContainer.frame)-30, 200.0)];
            self.firstBarChart.backgroundColor = [UIColor clearColor];
            self.firstBarChart.yLabelFormatter = ^(CGFloat yValue){
                CGFloat yValueParsed = yValue;
                NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
                return labelText;
            };
            self.firstBarChart.labelMarginTop = 5.0;
            self.firstBarChart.rotateForXAxisText = false ;
            self.firstBarChart.yMaxValue = log.waterGoal.intValue;
//            [self.firstBarChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5",@"SEP 6",@"SEP 7"]];
            // Adding gradient
            [topChartContainer addSubview:self.firstBarChart];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.firstBarChart.frame), CGRectGetWidth(self.frame), 20)];
            [topChartContainer addSubview:view];
            UILabel *label;
            {
                UIView *badView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 20, 20)];
                badView.backgroundColor = UIColorFromRGB(0xe85858);
                [badView.layer setCornerRadius:10];
                [view addSubview:badView];
                
                label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(badView.frame) + 5, 0, 31, 20)];
                label.textAlignment = NSTextAlignmentLeft;
                label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
                label.backgroundColor = CLEAR_COLOR;
                label.numberOfLines = 99;
                label.text = @"Бага";
                label.textColor = UIColorFromRGB(0xe85858);
                [view addSubview:label];
            }
            UILabel *label3;
            {
                UIView *badView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 5, 0, 20, 20)];
                badView.backgroundColor = UIColorFromRGB(0xffcc33);
                [badView.layer setCornerRadius:10];
                [view addSubview:badView];
                
                label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(badView.frame) + 5, 0, 32, 20)];
                label3.textAlignment = NSTextAlignmentLeft;
                label3.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
                label3.backgroundColor = CLEAR_COLOR;
                label3.numberOfLines = 99;
                label3.text = @"Дунд";
                label3.textColor = UIColorFromRGB(0xffcc33);
                [view addSubview:label3];
            }
            UILabel *label4;
            {
                UIView *badView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame) + 5, 0, 20, 20)];
                badView.backgroundColor = UIColorFromRGB(0x62d60d);
                [badView.layer setCornerRadius:10];
                [view addSubview:badView];
                
                label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(badView.frame) + 5, 0, 60, 20)];
                label4.textAlignment = NSTextAlignmentLeft;
                label4.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
                label4.backgroundColor = CLEAR_COLOR;
                label4.numberOfLines = 99;
                label4.text = @"Сайн";
                label4.textColor = UIColorFromRGB(0x62d60d);
                [view addSubview:label4];
            }
        }
        float height = 270;
        if ([UIScreen isiPhone5] || [UIScreen isiPhone4]) {
            height = 295;
        }
        
        UIView *bottomChartContainer = [[UIView alloc] initWithFrame:CGRectMake(10,  CGRectGetMaxY(topChartContainer.frame) + 10, CGRectGetWidth(self.frame) - 20, height)];
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
            titleLabel.text = @"БИЕИЙН ЖИН";
            titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            titleLabel.textColor = MAIN_COLOR;
            [bottomChartContainer addSubview:titleLabel];
            
            UILabel *yLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(-120, 40, CGRectGetHeight(topChartContainer.frame), 20)];
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
            
            self.secondBarChart = [[PNBarChart alloc] initWithFrame:CGRectMake(25, 40, CGRectGetWidth(topChartContainer.frame)- 30, 200.0)];
            self.secondBarChart.backgroundColor = [UIColor clearColor];
            self.secondBarChart.labelMarginTop = 5.0;
            self.secondBarChart.yLabelFormatter = ^(CGFloat yValue){
                CGFloat yValueParsed = yValue;
                NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
                return labelText;
            };
            self.secondBarChart.yMaxValue = log.weight.intValue + 25;
            self.secondBarChart.rotateForXAxisText = false ;
            [bottomChartContainer addSubview:self.secondBarChart];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.firstBarChart.frame), CGRectGetWidth(self.frame), 20)];
            [bottomChartContainer addSubview:view];
            UILabel *label;
            {
                UIView *badView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 20, 20)];
                badView.backgroundColor = UIColorFromRGB(0x0db1a0);
                [badView.layer setCornerRadius:10];
                [view addSubview:badView];
                
                label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(badView.frame) + 5, 0, 28, 20)];
                label.textAlignment = NSTextAlignmentLeft;
                label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
                label.backgroundColor = CLEAR_COLOR;
                label.numberOfLines = 99;
                label.text = @"Бага";
                label.textColor = UIColorFromRGB(0x0db1a0);
                [view addSubview:label];
            }
            UILabel *label3;
            {
                UIView *badView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame) + 5, 0, 20, 20)];
                badView.backgroundColor = UIColorFromRGB(0x62d60d);
                [badView.layer setCornerRadius:10];
                [view addSubview:badView];
                
                label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(badView.frame) + 5, 0, 40, 20)];
                label3.textAlignment = NSTextAlignmentLeft;
                label3.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
                label3.backgroundColor = CLEAR_COLOR;
                label3.numberOfLines = 99;
                label3.text = @"Хэвийн";
                label3.textColor = UIColorFromRGB(0x62d60d);
                [view addSubview:label3];
            }
            UILabel *label4;
            {
                UIView *badView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame) + 5, 0, 20, 20)];
                badView.backgroundColor = UIColorFromRGB(0xffa200);
                [badView.layer setCornerRadius:10];
                [view addSubview:badView];
                
                label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(badView.frame) + 5, 0, 60, 20)];
                label4.textAlignment = NSTextAlignmentLeft;
                label4.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
                label4.backgroundColor = CLEAR_COLOR;
                label4.numberOfLines = 99;
                label4.text = @"Илүүдэлтэй";
                label4.textColor = UIColorFromRGB(0xffa200);
                [view addSubview:label4];
            }
            UILabel *label5;
            {
                UIView *badView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label4.frame) + 5, 0, 20, 20)];
                badView.backgroundColor = UIColorFromRGB(0xea31a2);
                [badView.layer setCornerRadius:10];
                [view addSubview:badView];
                
                label5 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(badView.frame) + 5, 0, 60, 20)];
                label5.textAlignment = NSTextAlignmentLeft;
                label5.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10];
                label5.backgroundColor = CLEAR_COLOR;
                label5.numberOfLines = 99;
                label5.text = @"Тарган";
                label5.textColor = UIColorFromRGB(0xea31a2);
                [view addSubview:label5];
//                if ([UIScreen isiPhone5] || [UIScreen isiPhone4]) {
//                    badView.frame = CGRectMake(15, 25, 20, 20);
//                    label5.frame = CGRectMake(CGRectGetMaxX(badView.frame) + 5, 25, 60, 20);
//                    view.frame = CGRectMake(0, CGRectGetMaxY(self.firstBarChart.frame), CGRectGetWidth(self.frame), 50);
//                }
            }
        }
    }
    return self;
}


-(void)setFirstChartItems:(NSArray *)firstChartItems{
    _firstChartItems = firstChartItems;
    
    NSArray *weightTempArray = [_firstChartItems objectAtIndex:0];
    NSArray *weekTempArray = [_firstChartItems objectAtIndex:1];
    NSArray *colorTempArray = [_firstChartItems objectAtIndex:2];
//    self.firstBarChart.yMaxValue = [[_firstChartItems objectAtIndex:3] intValue];
    
    [self.firstBarChart setStrokeColors:colorTempArray];
    [self.firstBarChart setXLabels:weekTempArray];
    [self.firstBarChart setYValues:weightTempArray];
    
    [self.firstBarChart strokeChart];
    //    float maxValue = [[_firstChartItems objectAtIndex:3] floatValue];
    
}

-(void)setSecondChartItems:(NSArray *)secondChartItems{
    _secondChartItems = secondChartItems;
    
    NSArray *weightTempArray = [_secondChartItems objectAtIndex:0];
    NSArray *weekTempArray = [_secondChartItems objectAtIndex:1];
    NSArray *colorTempArray = [_secondChartItems objectAtIndex:2];
    
    [self.secondBarChart setStrokeColors:colorTempArray];
    [self.secondBarChart setXLabels:weekTempArray];
    [self.secondBarChart setYValues:weightTempArray];
    
    [self.secondBarChart strokeChart];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
