//
//  AppDelegate.h
//  Bonaque
//
//  Created by Puujee on 4/4/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftMenuViewController.h"
#import <SWRevealViewController/SWRevealViewController.h>
#import "TutorialViewController.h"
#import "DashboardViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property (strong, nonatomic) LeftMenuViewController *rearViewController;

- (void)showLoginViewController;

@end

