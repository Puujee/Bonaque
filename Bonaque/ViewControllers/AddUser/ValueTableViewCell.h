//
//  ValueTableViewCell.h
//  DentalClinic
//
//  Created by Puujee on 4/5/15.
//  Copyright (c) 2015 CronoSoft Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldedCellItem.h"

@interface ValueTableViewCell : UITableViewCell

@property (nonatomic, strong) TextFieldedCellItem   *item;
@property (nonatomic, strong) UIView *bgView;
@property (assign, nonatomic) BOOL isLast;
@property (assign, nonatomic) BOOL isFirst;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
