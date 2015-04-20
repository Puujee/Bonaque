//
//  CheckBoxCell.h
//  DentalClinic
//
//  Created by Puujee on 4/6/15.
//  Copyright (c) 2015 CronoSoft Ltd. All rights reserved.
//

#import "ValueTableViewCell.h"

@interface CheckBoxCell : ValueTableViewCell

@property (nonatomic, strong) NSArray *checkBoxValues;
@property (nonatomic, assign) int selectedValue;

@end
