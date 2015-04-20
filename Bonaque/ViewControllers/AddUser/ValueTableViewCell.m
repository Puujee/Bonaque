//
//  ValueTableViewCell.m
//  DentalClinic
//
//  Created by Puujee on 4/5/15.
//  Copyright (c) 2015 CronoSoft Ltd. All rights reserved.
//

#import "ValueTableViewCell.h"

@interface ValueTableViewCell (){
    UIView *sepView;
}

@end



@implementation ValueTableViewCell
@synthesize isLast = _isLast;
@synthesize isFirst = _isFirst;
@synthesize indexPath = _indexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        {
            _bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.contentView.frame) - 20, CGRectGetHeight(self.contentView.frame) +1)];
            _bgView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _bgView.backgroundColor = [UIColor clearColor];
            [self.contentView addSubview:_bgView];
        }
        
//        sepView = [[UIView alloc] initWithFrame:CGRectMake(11, CGRectGetHeight(self.contentView.frame), CGRectGetWidth(self.contentView.frame) - 22, 1)];
//        sepView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
//        sepView.backgroundColor = [UIColor whiteColor];
//        {
//            UIView *realSepView = [[UIView alloc] initWithFrame:CGRectMake(25, 0, CGRectGetWidth(sepView.frame) - 35, 1)];
//            realSepView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleLeftMargin  ;
//            realSepView.backgroundColor = UIColorFromRGB(0xb7b7b7);
//            [sepView addSubview:realSepView];
//        }
//        [self.contentView addSubview:sepView];
    }
    return self;
}

- (void)setIsFirst:(BOOL)isFirst{
    _isFirst = isFirst;
}

- (void)setIsLast:(BOOL)isLast{
    _isLast = isLast;
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews {
    [super layoutSubviews];
    sepView.hidden = NO;
    
    
//    UIBezierPath *cornersPath;
//    if (_isFirst && _isLast) {
//        cornersPath = [UIBezierPath bezierPathWithRoundedRect:_bgView.bounds  byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(5, 5)];
//        sepView.hidden = YES;
//        //Create a new layer to use as a mask
//        
//    }
//    else if (_isFirst) {
//        cornersPath = [UIBezierPath bezierPathWithRoundedRect:_bgView.bounds  byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) cornerRadii:CGSizeMake(5, 5)];
//    }
//    else if (_isLast){
//        cornersPath = [UIBezierPath bezierPathWithRoundedRect:_bgView.bounds  byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight) cornerRadii:CGSizeMake(5, 5)];
//        sepView.hidden = YES;
//    }
//    else{
//        cornersPath = [UIBezierPath bezierPathWithRect:_bgView.bounds];
//    }
//    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    
//    
//    // Set the path of the layer
//    
//    maskLayer.path = cornersPath.CGPath;
//    _bgView.layer.mask = maskLayer;
//    
//    
//    CAShapeLayer *shape = [CAShapeLayer layer];
//    shape.frame = _bgView.bounds;
//    shape.path = cornersPath.CGPath;
//    shape.lineWidth = 2.0f;
//    shape.fillColor = [UIColor whiteColor].CGColor;
//    shape.strokeColor = UIColorFromRGB(0xb7b7b7).CGColor;
//    [_bgView.layer addSublayer:shape];
}

@end
