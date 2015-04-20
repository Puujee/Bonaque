//
//  AbstractContainerView.h
//  Bonaque
//
//  Created by Puujee on 4/12/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractContainerView : UIView{
    UILabel *titleLabel;
    UIView *contentView;
    
    UIButton *backButton;
    UIButton *chooseButton;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isHideChooseButton;


-(void)showContentView;
-(void)chooseButtonSelected;
-(void)goBack;

@end
