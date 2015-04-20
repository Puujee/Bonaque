//
//  AddCustomCupView.m
//  Bonaque
//
//  Created by Puujee on 4/16/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AddCustomCupView.h"

@interface AddCustomCupView (){
    GSTextField *valueTextField;
    BOOL isInsert;
    NSString *weight;
}

@end

@implementation AddCustomCupView
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 10, CGRectGetWidth(contentView.frame), 60)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"ic_cup_custom"];
        [contentView addSubview:imageView];
        
        valueTextField = [[GSTextField alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 10, CGRectGetWidth(contentView.frame), 40)];
        valueTextField.borderStyle = UITextBorderStyleRoundedRect;
        valueTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        valueTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        valueTextField.secureTextEntry = NO;
        valueTextField.enabled = YES;
        valueTextField.placeholder = [LANGUAGE getStringForKey:@"water_size"];
        valueTextField.backgroundColor = [UIColor whiteColor];
        valueTextField.returnKeyType =  UIReturnKeyNext;
        valueTextField.keyboardType = UIKeyboardTypeNumberPad;
        valueTextField.textColor = [UIColor blackColor];
        valueTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addSubview:valueTextField];
        
        [chooseButton  setTitle:[[LANGUAGE getStringForKey:@"insert"] uppercaseString] forState:UIControlStateNormal];
        
        CGRect rect = contentView.frame;
        if ([UIScreen isiPhone4]) {
            rect.origin.y = rect.origin.y - 50;
        }
        rect.size.height = CGRectGetMaxY(valueTextField.frame) + 44;
        contentView.frame = rect;
    }
    return self ;
}

-(void)goBack{
    [super goBack];

}

-(void)chooseButtonSelected {
    if (valueTextField.text.length > 0) {
        weight = valueTextField.text;
        if (![DATABASE isHaveCupMl:weight.floatValue]) {
            isInsert = YES;
            Cup   *cup = [NSEntityDescription insertNewObjectForEntityForName:@"Cup" inManagedObjectContext:DATABASE.managedObjectContext];
            cup.id = [NSNumber numberWithInteger:[[[DATABASE cupFetchedResultController] fetchedObjects] count]  + 1];
            cup.ml = [NSNumber numberWithInt:[weight intValue]];
            cup.icon = @"ic_cup_custom-1";
            NSError *error1 = nil;
            if (![DATABASE.cupFetchedResultController   performFetch:&error1]) {
                NSLog(@"Unresolved error %@, %@", error1, [error1 userInfo]);
                abort();
            }
            [DATABASE saveChanges];
            
            PersonLog *lastLog = [DATABASE getTodaysPersonLog];
            
            float currentSize = lastLog.currentWaterLitre.floatValue + cup.ml.floatValue;
            float dailyGoal = lastLog.waterGoal.floatValue ;
            float percent = currentSize/(dailyGoal/100);
            ATLog(@"CurrentSize %@" , currentSize);
            ATLog(@"dailyGoal %@",dailyGoal);
            ATLog(@"percent %@",percent);
            lastLog.currentWaterLitre = [NSNumber numberWithFloat:currentSize];
            lastLog.currentWaterPercent = [NSNumber numberWithFloat:percent];
            [USERDEF setInteger:cup.ml.floatValue forKey:kLAST_DRINKED_ML];
            [DATABASE updatePurposeLog];
            
            NSError *error = nil;
            if (![DATABASE.personLogFetchedResultController   performFetch:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            [DATABASE saveChanges];
            [self goBack];
        }
        else{
            [Utils showAlert:[LANGUAGE getStringForKey:@"error_duplicate_cup"]];
        }
    }
    else {
        [Utils showAlert:[LANGUAGE getStringForKey:@"must_insert_weight"]];
    }
}

-(void)didFinishHide{
    if (isInsert) {
        [delegate didFinishAddCup];
    }
}

@end
