//
//  PurposeCongrulateDialog.m
//  Bonaque
//
//  Created by Puujee on 4/18/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "PurposeCongrulateDialog.h"

@interface PurposeCongrulateDialog (){
    UIImageView *imageView;
    
    UILabel *contentLabel;
    UIButton *shareButton;
}

@end

@implementation PurposeCongrulateDialog
@synthesize item = _item;
@synthesize mainViewController;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        titleLabel.text = @"Танд баяр хүргэе!";
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame) + 10, CGRectGetWidth(contentView.frame), 60)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.image = [UIImage imageNamed:@"dialog_alarm"];
        [contentView addSubview:imageView];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame) + 5, CGRectGetWidth(contentView.frame) - 20, 60)];
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        contentLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:16];
        contentLabel.text = @"";
        contentLabel.numberOfLines = 4;
        contentLabel.backgroundColor = CLEAR_COLOR;
        contentLabel.textColor = [UIColor blackColor];
        [contentView addSubview:contentLabel];
        
        CGRect rect = contentView.frame;
//        if ([UIScreen isiPhone4]) {
//            rect.origin.y = rect.origin.y - 50;
//        }
        rect.size.height = CGRectGetMaxY(contentLabel.frame) + 44 + 5;
        contentView.frame = rect;
        
        backButton .frame =  CGRectMake(0, CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame)/2, 44);
        
        shareButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(backButton.frame), CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame)/2, 44)];
        [shareButton  setTitle:[[LANGUAGE getStringForKey:@"Share"] uppercaseString] forState:UIControlStateNormal];
        [shareButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        shareButton.titleLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:15];
        [shareButton addTarget:self action:@selector(shareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        shareButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        [contentView addSubview:shareButton];
        
        chooseButton.hidden = YES;
    }
    return self ;
}

-(void)shareButtonClicked{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:ITUNES_DOWNLOAD_URL];
    content.contentTitle =  [NSString stringWithFormat:@"%@ авлаа.", _item.title];
    content.contentDescription = [NSString stringWithFormat:@"%@ өдөр ус уув.", _item.days];
    content.imageURL = [NSURL URLWithString:MAIN_IMAGE_URL];
    [FBSDKShareDialog showFromViewController:mainViewController
                                 withContent:content
                                    delegate:nil];
    [self goBack];
}


-(void)setItem:(Purpose *)item{
    _item = item;
    imageView.image=  [UIImage imageNamed:[NSString stringWithFormat:@"%@_achived", _item.icon]];
    
    
    contentLabel.text = [NSString stringWithFormat:@"Та %@ өдөр ус ууж \"%@\"-г авлаа.", _item.days, [_item.title uppercaseString]];
}

-(void)goBack{
    [super goBack];
}


-(void)didFinishHide{
    
}
@end
