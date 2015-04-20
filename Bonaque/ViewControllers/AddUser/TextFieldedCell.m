//
//  OrderCell.m
//  BarilgaMn
//
//  Created by Gantulga Tsendsuren on 10/3/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import "TextFieldedCell.h"
@interface TextFieldedCell (){
    UILabel *valueLabel;
    UIView *view;
    
    UIImageView *leftViewImage;
    UIView *sepView;
}
@property (nonatomic, strong) NSArray *sectionArray;
@end
@implementation TextFieldedCell
@synthesize valueTextField;
@synthesize item = _item;
@synthesize isHaveRightItem;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = CLEAR_COLOR;
        self.contentView.backgroundColor = CLEAR_COLOR;
        {
            self.valueTextField = [[GSTextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.bgView.frame) +15, 5, CGRectGetWidth(self.bgView.frame) - 30, CGRectGetHeight(self.contentView.frame) - 10)];
            valueTextField.borderStyle = UITextBorderStyleRoundedRect;
            valueTextField.autocorrectionType = UITextAutocorrectionTypeNo;
            valueTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
            valueTextField.secureTextEntry = NO;
            valueTextField.enabled = YES;
            valueTextField.text = @"";
            valueTextField.backgroundColor = [UIColor whiteColor];
            valueTextField.returnKeyType =  UIReturnKeyNext;
            valueTextField.keyboardType = UIKeyboardTypeDefault;
            valueTextField.textColor = [UIColor blackColor];
            valueTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth| UIViewAutoresizingFlexibleHeight;
            [self.contentView addSubview:valueTextField];
            
//            UIView *bgContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//            leftViewImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
//            leftViewImage.image = [UIImage imageNamed:@"home"];
//            leftViewImage.contentMode = UIViewContentModeScaleAspectFit;
//            [bgContentView addSubview:leftViewImage];
//            [valueTextField setLeftViewMode:UITextFieldViewModeAlways];
//            
//            valueTextField.leftView = bgContentView;
        }
    }
    return self;
}

-(void)setItem:(TextFieldedCellItem *)item{
    _item = item;
    
    valueTextField.placeholder = _item.placeHolderText;
    leftViewImage.image = [UIImage imageNamed:_item.imageName];
    if (isHaveRightItem) {
        UIView *bgContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        rightImage.image = [UIImage imageNamed:@"home"];
        rightImage.contentMode = UIViewContentModeScaleAspectFit;
        [bgContentView addSubview:rightImage];
        [valueTextField setRightViewMode:UITextFieldViewModeAlways];
        
        valueTextField.rightView = bgContentView;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
}



@end
