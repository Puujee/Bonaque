//
//  PickerContainerView.h
//  Bonaque
//
//  Created by Puujee on 4/7/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerContainerView;

@protocol PickerContainerViewDelegate <NSObject>

- (void)containerView:(PickerContainerView *)view didSelectPicker:(int)index;

@end

@interface PickerContainerView : UIView{
    id<PickerContainerViewDelegate>delegate;
}
@property (nonatomic, strong) id<PickerContainerViewDelegate>delegate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *listArray;

-(void)showContentView;

@end
