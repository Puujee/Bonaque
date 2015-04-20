//
//  OrderCell.h
//  BarilgaMn
//
//  Created by Gantulga Tsendsuren on 10/3/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSTextField.h"
#import "ValueTableViewCell.h"

/*!
 * @brief Нийтлэг Textfield бүхий Cell хэсэг
 */

@interface TextFieldedCell : ValueTableViewCell
@property (nonatomic, strong) GSTextField *valueTextField;
@property (nonatomic, assign) BOOL isHaveRightItem;


@end
