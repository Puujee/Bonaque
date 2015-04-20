//
//  CheckBoxCell.m
//  DentalClinic
//
//  Created by Puujee on 4/6/15.
//  Copyright (c) 2015 CronoSoft Ltd. All rights reserved.
//

#import "CheckBoxCell.h"

@interface  CheckBoxCell(){
    BOOL itsFirstTime;
    NSMutableArray *checkButtonArray;
}

@end

@implementation CheckBoxCell
@synthesize checkBoxValues = _checkBoxValues;
@synthesize selectedValue;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CLEAR_COLOR;
        self.contentView.backgroundColor = CLEAR_COLOR;
        checkButtonArray = [NSMutableArray array];
    }
    return self;
}

-(void)setCheckBoxValues:(NSArray *)checkBoxValues  {
    _checkBoxValues = checkBoxValues;
    if (!itsFirstTime) {
        itsFirstTime = YES;
        float width = (CGRectGetWidth(self.bgView.frame) - 30 - 5*_checkBoxValues.count)/_checkBoxValues.count;
        int margin = CGRectGetMinX(self.bgView.frame) + 15;
        int tag = 101;
        for (NSString *string in _checkBoxValues) {
            UIButton *radio2 = [UIButton buttonWithType:UIButtonTypeCustom];
            radio2.frame = CGRectMake(margin, 10, width, CGRectGetHeight(self.bgView.frame) - 10);
            radio2.tag = tag;
            [radio2 setBackgroundImage:[HXColor imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
            [radio2.layer setCornerRadius:4];
            radio2.clipsToBounds = YES;
            radio2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [radio2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [radio2 setTitle:string forState:UIControlStateNormal];
            [radio2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [radio2.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            [radio2 addTarget:self action:@selector(btnRadioClicked:) forControlEvents:UIControlEventTouchUpInside];
            [radio2 setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 5)];
            radio2.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            [self.contentView addSubview:radio2];
            
            [checkButtonArray addObject:radio2];
            margin += width + 10;
            tag++;
        }
        selectedValue = 101;
        [self reloadRadios];
    }
}

-(void)btnRadioClicked:(id)sender{
    UIButton  *selectedButton = (UIButton *)sender;
    selectedValue = (int)selectedButton.tag;
    [self reloadRadios];
}

- (void) reloadRadios {
    for (UIButton *button in checkButtonArray) {
        [button setImage:[UIImage imageNamed:@"ic_check"] forState:UIControlStateNormal];
        if (button.tag == selectedValue) {
            [button  setImage:[UIImage imageNamed:@"ic_check_active"] forState:UIControlStateNormal];
        }
    }
}

-(void)layoutSubviews   {
    [super layoutSubviews];
    float width = (CGRectGetWidth(self.bgView.frame) - 30 - 6*_checkBoxValues.count)/_checkBoxValues.count;
    int margin = CGRectGetMinX(self.bgView.frame) + 15;
    
    for (UIButton *button in checkButtonArray) {
        [button setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
        button.frame = CGRectMake(margin, 5, width, CGRectGetHeight(self.bgView.frame) - 10);
        
        margin = CGRectGetWidth(self.bgView.frame) - 15 - width + CGRectGetMinX(self.bgView.frame);
    }
    [self reloadRadios];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
