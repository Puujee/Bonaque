//
//  TutorialCollectionViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/8/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "TutorialCollectionViewCell.h"

@interface TutorialCollectionViewCell (){
    UIImageView *imageView;
    UILabel *titleLabel;
}

@end

@implementation TutorialCollectionViewCell
@synthesize item = _item;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:@"img_no_camera"];
        imageView.backgroundColor = [UIColor clearColor];
        [self addSubview:imageView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(imageView.frame) - 130, CGRectGetWidth(self.frame) - 40, 50)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 2;
        titleLabel.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:17];
        titleLabel.text = @"Бүтээгдэхүүний тухай";
        [self addSubview:titleLabel];
    }
    return self;
}

-(void)setItem:(TutorialItem *)item{
    _item = item;
    self.backgroundColor = _item.color;
    imageView.image = [UIImage imageNamed:_item.imageName];
    titleLabel.text = _item.title;
}

@end
