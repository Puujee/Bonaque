//
//  AbstractViewController.h
//  DentalClinic
//
//  Created by Puujee on 3/30/15.
//  Copyright (c) 2015 CronoSoft Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AbstractViewController : UIViewController

@property (nonatomic, assign) BOOL isNavigation;

-(void)itShowTransparentView:(BOOL)isShow;

- (void)drawShadow;
- (void)showBackButton;
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
