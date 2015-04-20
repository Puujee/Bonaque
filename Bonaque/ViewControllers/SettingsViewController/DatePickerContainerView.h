//
//  DatePickerContainerView.h
//  Bonaque
//
//  Created by Puujee on 4/8/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractContainerView.h"

@class DatePickerContainerView;

@protocol DatePickerContainerViewDelegate <NSObject>

-(void)containerView:(DatePickerContainerView *)view didSelectTime:(NSDate *)time ;

@end

@interface DatePickerContainerView : AbstractContainerView{
    id<DatePickerContainerViewDelegate>delegate;
}
@property (nonatomic, strong) id<DatePickerContainerViewDelegate>delegate;


@end
