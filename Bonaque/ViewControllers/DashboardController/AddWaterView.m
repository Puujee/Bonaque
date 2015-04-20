//
//  AddWaterView.m
//  Bonaque
//
//  Created by Puujee on 4/12/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AddWaterView.h"

@implementation AddWaterView
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0f];
        
        ATLog(@"");
        
        NSArray *cups = [DATABASE.cupFetchedResultController fetchedObjects];
        int margin = 5;
        int width = (CGRectGetWidth(contentView.frame)- margin *4)/3;
        int lastButtonMaxX = 0;
        int y = CGRectGetMaxY(titleLabel.frame);
        
        for (Cup *item in cups) {
            
            UIButton *cupButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            cupButton.backgroundColor = [UIColor greenColor];
            [cupButton setImage:[UIImage imageNamed:@"cup"] forState:UIControlStateNormal];
            cupButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cupButton.frame = CGRectMake(lastButtonMaxX + margin, y, width, 100);
            [cupButton setTitle:[NSString stringWithFormat:@"%@ ml", item.ml] forState:UIControlStateNormal];
            [cupButton addTarget:self action:@selector(selectCup:) forControlEvents:UIControlEventTouchUpInside];
            cupButton.tag = 100 + item.id.intValue;
            [cupButton setTitleEdgeInsets:UIEdgeInsetsMake(60.0,  width*-1, 10, 0)];
            [cupButton setImageEdgeInsets:UIEdgeInsetsMake(10.0, 0, 30.0, 0.0)];
            [cupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [cupButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
            [cupButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
            [contentView addSubview:cupButton];
            lastButtonMaxX += CGRectGetMaxX(cupButton.frame);
            if (lastButtonMaxX > CGRectGetWidth(contentView.frame)) {
                lastButtonMaxX = 0;
                y += CGRectGetMaxY(cupButton.frame) + 5;
            }
        }
    }
    return self ;
}

-(void)selectCup:(id)sender{
    UIButton *button = (UIButton *)sender;
    [self goBack];
    selected = YES;
    selectedIndex = (int)button.tag - 100;
}

-(void)didFinishHide{
    [delegate addedWaterLitre:selectedIndex];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
