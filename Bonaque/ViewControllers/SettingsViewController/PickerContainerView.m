//
//  PickerContainerView.m
//  Bonaque
//
//  Created by Puujee on 4/7/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "PickerContainerView.h"

@interface PickerContainerView()<UIPickerViewDataSource, UIPickerViewDelegate>{
    UIView *contentView;
    UILabel *titleLabel;
    
    UIScrollView *scrollView;
    UIPickerView *pickerView;
}

@end

@implementation PickerContainerView
@synthesize delegate;
@synthesize title = _title;
@synthesize listArray = _listArray;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0f];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(30, 50, CGRectGetWidth(frame) - 60,  250)];
        [contentView.layer setCornerRadius:5];
        contentView.center = self.center;
        contentView.hidden = YES;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.clipsToBounds = YES;
        [self addSubview:contentView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(contentView.frame),44)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        titleLabel.text = @"";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = MAIN_COLOR;
        [contentView addSubview:titleLabel];
        
        scrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(titleLabel.frame), CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame) - CGRectGetHeight(titleLabel.frame) - 44)];
        [contentView addSubview:scrollView];
        
        UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)  - 1, CGRectGetWidth(titleLabel.frame), 1)];
        sepView.backgroundColor = UIColorFromRGB(0xe3e3e3);
        [contentView addSubview:sepView];
        
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame)/2, 44)];
        [backButton  setTitle:[LANGUAGE getStringForKey:@"close"] forState:UIControlStateNormal];
        [backButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:15];
        [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:backButton];
        
        UIButton *chooseButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backButton.frame), CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame)/2, 44)];
        [chooseButton  setTitle:[LANGUAGE getStringForKey:@"choose"] forState:UIControlStateNormal];
        [chooseButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        chooseButton.titleLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:15];
        [chooseButton addTarget:self action:@selector(chooseButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:chooseButton];
        
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(sepView.frame), CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame) - 90)];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        pickerView.tag = 4;
        [pickerView reloadAllComponents];
        pickerView.showsSelectionIndicator = YES;
        
        [contentView addSubview:pickerView];
        
        UIView *bottomSepView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(backButton.frame)  + 1, CGRectGetWidth(titleLabel.frame), 1)];
        bottomSepView.backgroundColor = UIColorFromRGB(0xe3e3e3);
        [contentView addSubview:bottomSepView];
        
    }
    return self ;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    ATLog(@"%@", _title);
    titleLabel.text = _title;
}


-(void)goBack{
    [UIView transitionWithView:contentView
                      duration:0.5f
                       options:( UIViewAnimationOptionTransitionFlipFromLeft     )
                    animations: ^{
                        contentView.hidden = YES;
                    }
                    completion:^(BOOL finished) {
                        [contentView removeFromSuperview];
                        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
                        } completion:^(BOOL finished) {
                            [self removeFromSuperview];
                        }];
                    }];
}

-(void)chooseButtonSelected{
    [delegate containerView:self  didSelectPicker:(int)[pickerView selectedRowInComponent:0]];
    [self goBack];
}


-(void)showContentView{
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8f];
    } completion:^(BOOL finished) {
        [self startContentViewAnimation];
    }];
}

-(void)startContentViewAnimation{
    [UIView transitionWithView:contentView
                      duration:0.5f
                       options:( UIViewAnimationOptionTransitionFlipFromRight     )
                    animations: ^{
                        contentView.hidden = NO;
                    }
                    completion:^(BOOL finished) {
                        
                    }];
}


#pragma mark
#pragma mark UIPickerDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  _listArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *names = [_listArray objectAtIndex:row];
    return names;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

//Do something Select Picker
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

@end
