//
//  ToastView.m
//  Bonaque
//
//  Created by Puujee on 4/20/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "UIView+Toast.h"

#import <objc/runtime.h>

static const NSTimeInterval CSToastFadeDuration = 0.2;

// associative reference keys
static const NSString * CSToastTimerKey         = @"CSToastTimerKey";
static const NSString * CSToastActivityViewKey  = @"CSToastActivityViewKey";
static const NSString * CSToastTapCallbackKey   = @"CSToastTapCallbackKey1";
static const float ToastViewTag = 102;

typedef void (^ActionBlock)();

ActionBlock _actionBlock;

@implementation UIView (Toast)

- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position  undoButton:(void(^)(void))tapCallback{
    UIView *toast = [self viewForTitle:message undoHandler:tapCallback];
    _actionBlock = tapCallback;
    objc_setAssociatedObject (toast, &CSToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self showToast:toast duration:duration position:position];
}

- (void)showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position {
    [self showToast:toast duration:duration position:position tapCallback:nil];
    
}

- (void)showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
      tapCallback:(void(^)(void))tapCallback
{
    toast.center = [position CGPointValue];
    toast.alpha = 0.0;
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(handleToastTapped:)];
    [toast addGestureRecognizer:recognizer];
    toast.userInteractionEnabled = YES;
    toast.exclusiveTouch = YES;
    
    [self addSubview:toast];
    
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &CSToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//                         objc_setAssociatedObject (toast, &CSToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}

- (void)hideToast:(UIView *)toast {
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}
#pragma mark - Events

- (void)toastTimerDidFinish:(NSTimer *)timer {
    [self hideToast:(UIView *)timer.userInfo];
}

- (void)handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &CSToastTimerKey);
    [timer invalidate];
    
//    void (^callback)(void) = objc_getAssociatedObject(self, &CSToastTapCallbackKey);
//    if (callback) {
//        callback();
//    }
    [self hideToast:recognizer.view];
}

- (UIView *)viewForTitle:(NSString *)title undoHandler:(void(^)(void))tapCallback{
    // dynamically build a toast view with any combination of message, title, & image.
    if(title == nil) return nil;
    UILabel *titleLabel = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] initWithFrame:CGRectMake(20 , 0, (CGRectGetWidth(self.frame) - 40), 40)];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = 10;
    wrapperView.clipsToBounds = YES;
    wrapperView.tag = ToastViewTag;
//    wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
//    wrapperView.layer.shadowOpacity = 10;
//    wrapperView.layer.shadowRadius = 10;
//    wrapperView.layer.shadowOffset = CGSizeMake(10, 10);
    
    wrapperView.backgroundColor = [UIColorFromRGB(0xffc107) colorWithAlphaComponent:0.9];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, (CGRectGetWidth(wrapperView.frame) - 20)/3*1.7, 40)];
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.alpha = 1.0;
    titleLabel.numberOfLines = 2;
    titleLabel.text = title;
    [wrapperView addSubview:titleLabel];
    
    
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5, 5, 1, 30)];
    sepView.backgroundColor = [UIColor whiteColor];
    [wrapperView addSubview:sepView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Буцаах" forState:UIControlStateNormal];
    [button setBackgroundImage:[HXColor imageWithColor:UIColorFromRGB(0xffc107)] forState:UIControlStateNormal];
    button.frame = CGRectMake(CGRectGetMaxX(sepView.frame), 0, CGRectGetWidth(wrapperView.frame) - CGRectGetMaxX(sepView.frame), 40);
    [button addTarget:self action:@selector(toastUndoButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [wrapperView addSubview:button];
    
    return wrapperView;
}

- (void)toastUndoButtonClicked{
    UIView *toast = [self viewWithTag:ToastViewTag];
    [self hideToast:toast];
    _actionBlock();
}


@end
