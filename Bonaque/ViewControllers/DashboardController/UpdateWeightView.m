//
//  UpdateWeightView.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "UpdateWeightView.h"
#import "GSTextField.h"

@interface UpdateWeightView (){
    GSTextField *valueTextField;
    BOOL isInsert;
    NSString *weight;
}

@end

@implementation UpdateWeightView
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        valueTextField = [[GSTextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(contentView.frame), 40)];
        valueTextField.borderStyle = UITextBorderStyleRoundedRect;
        valueTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        valueTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        valueTextField.secureTextEntry = NO;
        valueTextField.enabled = YES;
        valueTextField.placeholder = [LANGUAGE getStringForKey:@"weight"];
        valueTextField.backgroundColor = [UIColor whiteColor];
        valueTextField.returnKeyType =  UIReturnKeyNext;
        valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
        valueTextField.textColor = [UIColor blackColor];
        valueTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addSubview:valueTextField];
        
        [chooseButton  setTitle:[[LANGUAGE getStringForKey:@"insert"] uppercaseString] forState:UIControlStateNormal];
        
        CGRect rect = contentView.frame;
        rect.size.height = CGRectGetMaxY(valueTextField.frame) + 44;
        contentView.frame = rect;
    }
    return self ;
}

-(void)goBack{
    [super goBack];
    if (!isInsert) {
        NSDate *date = [USERDEF objectForKey:kLAST_UPDATE_WEIGHT];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSUInteger units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *comps = [[NSCalendar currentCalendar] components:units fromDate:date];
        comps.day = comps.day + 1;
        NSDate *tomorrowMidnight = [gregorian dateFromComponents:comps];
        [USERDEF setObject:tomorrowMidnight forKey:kLAST_UPDATE_WEIGHT];
    }
}

-(void)chooseButtonSelected {
    if (valueTextField.text.length > 0) {
        
        isInsert = YES;
        weight = valueTextField.text;
        
        [USERDEF setObject:[NSDate date] forKey:kLAST_UPDATE_WEIGHT];
        Person *user = [DATABASE getUser];
        user.weight = [NSNumber numberWithFloat:weight.floatValue];
        
        NSError *error = nil;
        if (![DATABASE.personFetchedResultController   performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [DATABASE saveChanges];
        [DATABASE updateWeightLastPersonLog];
        [self goBack];
    }
    else {
        [Utils showAlert:@"Та жингээ оруулна уу."];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 5) ? NO : YES;
}

-(void)didFinishHide{
    [delegate didFinishUpdateWeight];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
