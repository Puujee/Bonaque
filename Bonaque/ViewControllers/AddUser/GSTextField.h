//
//  GSTextField.h
//  BarilgaMn
//
//  Created by Gantulga Tsendsuren on 10/4/13.
//  Copyright (c) 2013 Sorako. All rights reserved.
//

#import <UIKit/UIKit.h>


/*!
 * @brief  Custom placeHolder бүхий textfield
 */

@interface GSTextField : UITextField
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIColor *placeHolderTextColor;
@property (nonatomic, assign) int placeHolderFontSize;

@end
