//
//  AdviceDetailView.m
//  Bonaque
//
//  Created by Puujee on 4/20/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AdviceDetailView.h"

@interface AdviceDetailView (){
    UIImageView *imageView;
    
    UILabel *contentLabel;
    UILabel *textLabel;
    UIButton *shareButton;
    
    UIScrollView *scrollView;
}

@end

@implementation AdviceDetailView

@synthesize item = _item;
@synthesize mainViewController;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        titleLabel.text = @"Зөвлөгөө";
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(contentView.frame), 200)];
        scrollView.backgroundColor = [UIColor whiteColor];
        [contentView addSubview:scrollView];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, CGRectGetWidth(self.frame) - 30, 10)];
        textLabel.backgroundColor = CLEAR_COLOR;
        textLabel.numberOfLines = 999;
        textLabel.textColor = [UIColor blackColor];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.f];
        textLabel.text = @"";
        [scrollView addSubview:textLabel];
        
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, CGRectGetWidth(contentView.frame) - 30, 60)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [scrollView addSubview:imageView];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, CGRectGetWidth(contentView.frame) - 30, 10)];
        contentLabel.backgroundColor = CLEAR_COLOR;
        contentLabel.numberOfLines = 999;
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        contentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.f];
        contentLabel.text = @"";
        [scrollView addSubview:contentLabel];
        
        CGRect rect = contentView.frame;
        //        if ([UIScreen isiPhone4]) {
        //            rect.origin.y = rect.origin.y - 50;
        //        }
        rect.size.height = CGRectGetMaxY(scrollView.frame) + 44;
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
    content.contentTitle =  [NSString stringWithFormat:@"Усны тухай зөвлөгөө."];
    content.imageURL = [NSURL URLWithString:MAIN_IMAGE_URL];
    content.contentDescription = [NSString stringWithFormat:@"%@.", _item.content];
    [FBSDKShareDialog showFromViewController:mainViewController
                                 withContent:content
                                    delegate:nil];
    [self goBack];
}


-(void)setItem:(Purpose *)item{
    _item = item;
    imageView.frame = CGRectMake(15, 10, CGRectGetWidth(contentView.frame) - 30, 60);
    imageView.image = [UIImage imageNamed:_item.icon];
    
    
    CGRect contentSize = [_item.content boundingRectWithSize:CGSizeMake(CGRectGetWidth(contentView.frame) - 30, 9999)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:contentLabel.font}
                                                     context:nil];
    contentLabel.text = _item.content;
    contentLabel.frame = CGRectMake(15, CGRectGetMaxY(imageView.frame) + 10, CGRectGetWidth(contentView.frame) - 30, contentSize.size.height);
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(contentView.frame), CGRectGetMaxY(contentLabel.frame) + 10);
    ATLog(@"%@", contentLabel.frame);
    
    if (scrollView.contentSize.height <= 200) {
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame) + 1);
    }
}

-(void)itsSourceClicked{
    self.title = @"Эх сурвалж";
    scrollView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(contentView.frame), 230);
    NSString *sourceText = @"World Health Organization. Guidelines for drinking water quality 4th edition. 2011.\n\nХөдөөгийн хүн амын ус хангамж, ариун цэвэр, эрүүл ахуй ном. 2007 он.";
    imageView.frame = CGRectMake(15, 10, CGRectGetWidth(contentView.frame) - 30, 60);
    imageView.image = [UIImage imageNamed:@"imd_advice_big"];
    
    CGRect contentSize = [sourceText boundingRectWithSize:CGSizeMake(CGRectGetWidth(contentView.frame) - 30, 9999)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName:contentLabel.font}
                                                     context:nil];
    contentLabel.text = sourceText;
    contentLabel.frame = CGRectMake(15, CGRectGetMaxY(imageView.frame) + 10, CGRectGetWidth(contentView.frame) - 30, contentSize.size.height);
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(contentView.frame), CGRectGetMaxY(contentLabel.frame) + 10);
    
    CGRect rect = contentView.frame;
    //        if ([UIScreen isiPhone4]) {
    //            rect.origin.y = rect.origin.y - 50;
    //        }
    rect.size.height = CGRectGetMaxY(scrollView.frame) + 44;
    contentView.frame = rect;
    
    if (scrollView.contentSize.height <= 200) {
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame) + 1);
    }
    backButton .frame =  CGRectMake(0, CGRectGetHeight(contentView.frame) - 44, CGRectGetWidth(titleLabel.frame), 44);
    shareButton.hidden = YES;
}

-(void)goBack{
    [super goBack];
}


-(void)didFinishHide{
    
}

@end
