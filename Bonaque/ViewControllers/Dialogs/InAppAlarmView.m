//
//  InAppAlarmView.m
//  Bonaque
//
//  Created by Puujee on 4/17/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "InAppAlarmView.h"

@interface InAppAlarmView (){
    UILabel *contentLabel;
}

@end

@implementation InAppAlarmView

@synthesize contentTitle = _contentTitle;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        titleLabel.text = @"СЭРҮҮЛЭГ";
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 10, CGRectGetWidth(contentView.frame), 60)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:@"dialog_alarm"];
        [contentView addSubview:imageView];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame) + 5, CGRectGetWidth(contentView.frame) - 40, 34)];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        contentLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:17];
        contentLabel.text = @"";
        contentLabel.backgroundColor = CLEAR_COLOR;
        contentLabel.textColor = [UIColor blackColor];
        [contentView addSubview:contentLabel];
        
        CGRect rect = contentView.frame;
        if ([UIScreen isiPhone4]) {
            rect.origin.y = rect.origin.y - 50;
        }
        rect.size.height = CGRectGetMaxY(contentLabel.frame) + 44 + 5;
        contentView.frame = rect;
        
        backButton .frame =  CGRectMake(0, CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame), 44);
        chooseButton.hidden = YES;
    }
    return self ;
}

-(void)setContentTitle:(NSString *)title   {
    _contentTitle = title;
    contentLabel.text = _contentTitle;
}

-(void)goBack{
    [super goBack];
    
}


-(void)didFinishHide{

}

@end
