//
//  PurposeTableViewCell.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "PurposeTableViewCell.h"

@interface PurposeTableViewCell (){
    NSDateFormatter *dateFormatter;
}

@end

@implementation PurposeTableViewCell
@synthesize item = _item;
@synthesize isFirst = _isFirst;
@synthesize isLast = _isLast;

-(void)setItem:(Purpose *)item{
    _item = item;
    _topLineView.backgroundColor = [UIColor blackColor];
    _bottomLineView.backgroundColor = [UIColor blackColor];
    _purposeTitleLabel.text = _item.title;
    _purposeTitleLabel.textColor = [UIColor blackColor];
    _purposeImageView.image = [UIImage imageNamed:_item.icon];
    [_purposeImageView.layer setBorderWidth:0];

    _checkLabel.hidden = YES;
    
    UIColor *borderColor = UIColorFromRGB(0x67be27);
    
    
    
    PurposeLog *purposeLog = [DATABASE getPurposeLogWithID:_item.purposeID.intValue];
    if (purposeLog) {
        _dayLabel.text = [NSString stringWithFormat:@"%@ %@", purposeLog.daysRemaining , [LANGUAGE getStringForKey:@"days_remaining"]];
        _dayLabel.textColor = MAIN_COLOR;
        _purposeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_achived", _item.icon]];

        if (purposeLog.daysRemaining.intValue <= 0) {
            [_purposeImageView.layer setBorderColor:borderColor.CGColor];
            [_purposeImageView.layer setBorderWidth:2];
            
            _dayLabel.text = [dateFormatter stringFromDate:purposeLog.endDate];
            
            _purposeTitleLabel.textColor = MAIN_COLOR;
            _purposeDescription.text = [NSString stringWithFormat:@"Баяр хүргэе. Та %@ хоног ус уугаад энэ цомыг авсан байна.", _item.days];
          
            _topLineView.backgroundColor = borderColor;
            _bottomLineView.backgroundColor = borderColor;
            _checkLabel.hidden = NO;

        }
        else{
            _purposeDescription.text = item.content;
            _dayLabel.textColor = MAIN_COLOR;
            [self checkPrevItem:purposeLog];
            [_purposeImageView.layer setBorderColor:[UIColor greenColor].CGColor];
            [_purposeImageView.layer setBorderWidth:0];
        }
    }
    else{
        _dayLabel .textColor = [UIColor lightGrayColor];
        _purposeDescription.textColor = [UIColor grayColor];
        _dayLabel.text = [NSString stringWithFormat:@"%@ %@", item.days , [LANGUAGE getStringForKey:@"days_remaining"]];
        _purposeDescription.text = item.content;
        
    }
}

-(void)checkPrevItem:(PurposeLog *)item{
    NSArray *logItems = [DATABASE.purposeLogFetchedResultController fetchedObjects];
    if (logItems.count > 1) {
        float index = [logItems indexOfObject:item];
        if (index > 0) {
            PurposeLog *log = [logItems objectAtIndex:index - 1];
            if (log.daysRemaining.intValue == 0) {
                _topLineView.backgroundColor = UIColorFromRGB(0x67be27);
            }
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
    [_purposeImageView.layer setCornerRadius:32];
    _purposeImageView.clipsToBounds = YES;
    
    [_checkLabel.layer setCornerRadius:10];
    [_checkLabel.layer setBorderColor:UIColorFromRGB(0x67be27).CGColor];
    [_checkLabel.layer setBorderWidth:2];
    _checkLabel.clipsToBounds = YES;
    _checkLabel.hidden = YES;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy.MM.dd";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _topLineView.hidden = NO;
    _bottomLineView.hidden = NO;
    if (_isFirst) {
        _topLineView.hidden = YES;
    }
    else if (_isLast){
        _bottomLineView.hidden = YES;
    }
}

@end
