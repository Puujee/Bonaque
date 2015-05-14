//
//  DialogView.m
//  Bonaque
//
//  Created by Puujee on 4/18/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "DialogView.h"

@interface  DialogView (){
    UIView *contentView;
    UILabel *titleLabel;
    UIButton *backButton;
    
    UILabel *contentTitleLabel;
    
    UIImageView *bgImageView;
    UIImageView *contentImageView;
}

@end

@implementation DialogView

@synthesize type = _type;



-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        ATLog(@"");
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0f];
        
        contentView = [[UIView alloc] initWithFrame:self.bounds];
        [contentView.layer setCornerRadius:5];
        contentView.center = self.center;
        contentView.hidden = YES;
        contentView.backgroundColor = [UIColor clearColor];
        contentView.clipsToBounds = YES;
        [self addSubview:contentView];
        
        bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 440)];
        bgImageView.center = contentView.center;
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [contentView addSubview:bgImageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMinX(bgImageView.frame), CGRectGetWidth(contentView.frame),44)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        titleLabel.text = @"";
        titleLabel.numberOfLines = 3;
        titleLabel.backgroundColor = CLEAR_COLOR;
        titleLabel.textColor = [UIColor blackColor];
        [contentView addSubview:titleLabel];
        
        contentTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,CGRectGetMinX(bgImageView.frame), CGRectGetWidth(contentView.frame),44)];
        contentTitleLabel.textAlignment = NSTextAlignmentCenter;
        contentTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        contentTitleLabel.font = [UIFont fontWithName:@"MogulPopularScript" size:45];
        contentTitleLabel.text = @"Баяр хүргэе";
        contentTitleLabel.numberOfLines = 3;
        contentTitleLabel.backgroundColor = CLEAR_COLOR;
        contentTitleLabel.textColor = [UIColor blackColor];
        [contentView addSubview:contentTitleLabel];
        
        
        contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 270, 440)];
        contentImageView.center = bgImageView.center;
        contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        [contentView addSubview:contentImageView];
//
//        UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)  - 1, CGRectGetWidth(titleLabel.frame), 1)];
//        sepView.backgroundColor = UIColorFromRGB(0xe3e3e3);
//        [contentView addSubview:sepView];
//        
        backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame)/2, 44)];
        [backButton  setTitle:@"OK" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25];
        [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        backButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [contentView addSubview:backButton];
        
    }
    return self ;
}

-(void)setType:(DialogType)type{
    _type = type;
    if (_type == kCongrulateDialog) {
        bgImageView.image = [UIImage imageNamed:@"dialog_1"];
        
        bgImageView.frame = CGRectMake(0, 0, 270, 440);
        bgImageView.center = self.center;
        
        titleLabel.frame = CGRectMake(CGRectGetMinX(bgImageView.frame) + 10 ,CGRectGetMinY(bgImageView.frame) + 10, CGRectGetWidth(bgImageView.frame) - 20,50);
        titleLabel.text = @"Та өдрийн хэрэгцээгээ хангалттай авч чадлаа.";
        
        contentImageView.frame = CGRectMake(CGRectGetMinX(bgImageView.frame) +((CGRectGetWidth(bgImageView.frame) - 250)/2), CGRectGetMaxY(titleLabel.frame) + 10, 250, 210);
        contentImageView.image = [UIImage imageNamed:@"dialog_1-symbol"];
        
        backButton.frame = CGRectMake(CGRectGetMinX(bgImageView.frame), CGRectGetMaxY(contentImageView.frame) + 10, CGRectGetWidth(bgImageView.frame), 80);
        
        contentTitleLabel.text = @"Баяр хүргэе!";
        contentTitleLabel.frame = CGRectMake(CGRectGetMinX(bgImageView.frame) + 40, CGRectGetMaxY(titleLabel.frame) + 10, CGRectGetWidth(bgImageView.frame) - 80, 210);
        contentTitleLabel.textColor = UIColorFromRGB(0x62d60d);
    }
    else if (_type == kWarningDialog){
        bgImageView.image = [UIImage imageNamed:@"dialog_2"];
        
        bgImageView.frame = CGRectMake(0, 0, 270, 322);
        bgImageView.center = self.center;
        
        contentTitleLabel.text = @"Анхаар!";
        contentTitleLabel.frame = CGRectMake(CGRectGetMinX(bgImageView.frame) + 40, CGRectGetMinY(bgImageView.frame) + 10, CGRectGetWidth(bgImageView.frame) - 80, 50);
        contentTitleLabel.textColor = [UIColor whiteColor];
        
        
        contentImageView.frame = CGRectMake(CGRectGetMinX(bgImageView.frame) +((CGRectGetWidth(bgImageView.frame) - 137)/2), CGRectGetMaxY(contentTitleLabel.frame) + 10, 137, 137);
        contentImageView.image = [UIImage imageNamed:@"dialog_2-symbol"];
        
        titleLabel.frame = CGRectMake(CGRectGetMinX(bgImageView.frame) + 10 ,CGRectGetMaxY(contentImageView.frame) + 10, CGRectGetWidth(bgImageView.frame) - 20,50);
        titleLabel.text = @"Таны өдрийн усны хэрэглээ хэтрэх гэж байна.";
        titleLabel.textColor = [UIColor whiteColor];

        
        if ([UIScreen isiPhone6Plus]){
            backButton.frame = CGRectMake(CGRectGetMinX(bgImageView.frame), CGRectGetMaxY(titleLabel.frame) + 15, CGRectGetWidth(bgImageView.frame), 44);
        }
        else{
            backButton.frame = CGRectMake(CGRectGetMinX(bgImageView.frame), CGRectGetMaxY(titleLabel.frame) + 5, CGRectGetWidth(bgImageView.frame), 44);
        }
    }
    else if (_type == kSuperWarningDialog){
        bgImageView.image = [UIImage imageNamed:@"dialog_3"];
        
        bgImageView.frame = CGRectMake(0, 0, 270, 322);
        bgImageView.center = self.center;
        
        
        contentTitleLabel.text = @"Хангалттай!!!";
        contentTitleLabel.frame = CGRectMake(CGRectGetMinX(bgImageView.frame) + 20, CGRectGetMinY(bgImageView.frame) + 10, CGRectGetWidth(bgImageView.frame) - 40, 50);
        contentTitleLabel.textColor = [UIColor whiteColor];
        contentTitleLabel.font = [UIFont fontWithName:@"MogulPopularScript" size:38];
        
        
        contentImageView.frame = CGRectMake(CGRectGetMinX(bgImageView.frame) +((CGRectGetWidth(bgImageView.frame) - 137)/2), CGRectGetMaxY(contentTitleLabel.frame) + 10, 137, 137);
        contentImageView.image = [UIImage imageNamed:@"dialog_3-symbol"];
        
        titleLabel.frame = CGRectMake(CGRectGetMinX(bgImageView.frame) + 10 ,CGRectGetMaxY(contentImageView.frame) + 10, CGRectGetWidth(bgImageView.frame) - 20,50);
        titleLabel.text = @"Таны өдрийн усны хэрэглээ хэтэрсэн байна.";
        titleLabel.textColor = [UIColor whiteColor];
        
        
        if ([UIScreen isiPhone6Plus]){
            backButton.frame = CGRectMake(CGRectGetMinX(bgImageView.frame), CGRectGetMaxY(titleLabel.frame) + 15, CGRectGetWidth(bgImageView.frame), 44);
        }
        else{
            backButton.frame = CGRectMake(CGRectGetMinX(bgImageView.frame), CGRectGetMaxY(titleLabel.frame) + 5, CGRectGetWidth(bgImageView.frame), 44);
        }
    }
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

@end
