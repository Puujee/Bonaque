//
//  DatePickerContainerView.m
//  Bonaque
//
//  Created by Puujee on 4/8/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "DatePickerContainerView.h"

@interface DatePickerContainerView (){
    UIDatePicker *pickerView;
}

@end

@implementation DatePickerContainerView

@synthesize delegate;
@synthesize title = _title;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0f];
        
        pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(contentView.frame), CGRectGetHeight(contentView.frame) - CGRectGetHeight(titleLabel.frame) - 44)];
        pickerView.datePickerMode = UIDatePickerModeTime;
        pickerView.backgroundColor = [UIColor clearColor];
        [pickerView addTarget:self
                       action:@selector(dateChanged:)
             forControlEvents:UIControlEventValueChanged];
        [contentView addSubview:pickerView];
    }
    return self ;
}

- (void)dateChanged:(id)sender
{
    UIDatePicker *datePicker = (UIDatePicker *)sender;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    ATLog(@"ИХ БАЙНА %@   %@", [Utils dateFromHouurs:[USERDEF valueForKey:kSTART_TIME]], datePicker.date);
}



-(void)chooseButtonSelected{
    [self goBack];
    [delegate containerView:self didSelectTime:pickerView.date];
    [super chooseButtonSelected];
}

@end
