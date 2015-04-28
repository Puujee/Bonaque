//
//  AbstractContainerView.m
//  Bonaque
//
//  Created by Puujee on 4/12/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AbstractContainerView.h"

@implementation AbstractContainerView
@synthesize title = _title;
@synthesize isHideChooseButton = _isHideChooseButton;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        ATLog(@"");
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0f];
        
        contentView = [[UIView alloc] initWithFrame:CGRectMake(30, 50, CGRectGetWidth(frame) - 60,  300)];
        [contentView.layer setCornerRadius:5];
        contentView.center = self.center;
        contentView.hidden = YES;
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.clipsToBounds = YES;
        [self addSubview:contentView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,CGRectGetWidth(contentView.frame),44)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        titleLabel.text = @"";
        titleLabel.backgroundColor = CLEAR_COLOR;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = MAIN_COLOR;
        [contentView addSubview:titleLabel];
        
        UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)  - 1, CGRectGetWidth(titleLabel.frame), 1)];
        sepView.backgroundColor = UIColorFromRGB(0xe3e3e3);
        [contentView addSubview:sepView];
        
        backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame)/2, 44)];
        [backButton  setTitle:[[LANGUAGE getStringForKey:@"close"] uppercaseString] forState:UIControlStateNormal];
        [backButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:15];
        [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        backButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [contentView addSubview:backButton];
        
        chooseButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backButton.frame), CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame)/2, 44)];
        [chooseButton  setTitle:[[LANGUAGE getStringForKey:@"choose"] uppercaseString] forState:UIControlStateNormal];
        [chooseButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        chooseButton.titleLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:15];
        [chooseButton addTarget:self action:@selector(chooseButtonSelected) forControlEvents:UIControlEventTouchUpInside];
        chooseButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [contentView addSubview:chooseButton];
        
        UIView *bottomSepView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(backButton.frame)  + 1, CGRectGetWidth(titleLabel.frame), 1)];
        bottomSepView.backgroundColor = UIColorFromRGB(0xe3e3e3);
        bottomSepView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [contentView addSubview:bottomSepView];
        
    }
    return self ;
}

-(void)setIsHideChooseButton:(BOOL)isHideChooseButton   {
    _isHideChooseButton = isHideChooseButton;
    if (isHideChooseButton) {
        [chooseButton     removeFromSuperview];
        backButton.frame = CGRectMake(0, CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame), 44);
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    ATLog(@"%@", title);
    titleLabel.text = _title;
}

-(void)chooseButtonSelected{
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
                            [self    didFinishHide];
                            [self removeFromSuperview];
                        }];
                    }];
}

-(void)didFinishHide{
    
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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
