//
//  AppDelegate.m
//  Bonaque
//
//  Created by Puujee on 4/4/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "PickerContainerView.h"
#import "ChangeLanguageViewController.h"
#import "InAppAlarmView.h"

@interface AppDelegate () <PickerContainerViewDelegate, SWRevealViewControllerDelegate>

@end

@implementation AppDelegate
@synthesize viewController = _viewController;
@synthesize rearViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    self.window.backgroundColor = BG_COLOR;
    [self setStaticValues];
    [self showLoginViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)showLoginViewController{
    if  (![USERDEF boolForKey:kITS_SHOW_TUT]){
//        [Utils setAlarm:@"bla" withDate:@"07:34"];
//        [Utils setAlarmSchedule];
//        PickerContainerView *pickerContainer = [[PickerContainerView alloc] initWithFrame:self.window.bounds];
//        pickerContainer.title = [LANGUAGE getStringForKey:@"choose_lang"];
//        pickerContainer.listArray = @[[LANGUAGE getStringForKey:@"en"], [LANGUAGE getStringForKey:@"mn"]];
//        pickerContainer.delegate = self;
//        pickerContainer.tag  = 201;
//        [self.window addSubview:pickerContainer];
//        [pickerContainer showContentView];
//        ChangeLanguageViewController    *frontViewController = [[ChangeLanguageViewController alloc] initWithNibName:nil bundle:nil];
//        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
//        self.window.rootViewController = frontNavigationController;

        TutorialViewController *tutViewController = [[TutorialViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:tutViewController];
        nc1.navigationBarHidden = YES;
        self.window.rootViewController = nc1;
        return;
    }
    self.viewController = nil;
    self.rearViewController = nil;
    [[UINavigationBar appearance] setBackgroundImage:[HXColor imageWithColor:MAIN_COLOR] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:MAIN_LIGHT_FONT size:20], NSFontAttributeName, [UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
    DashboardViewController *frontViewController = [[DashboardViewController alloc] initWithNibName:nil bundle:nil];
    self.rearViewController = [[LeftMenuViewController alloc] init];
    self.rearViewController.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    frontNavigationController.navigationBar.translucent = NO;
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:self.rearViewController frontViewController:frontNavigationController];
    revealController.frontViewShadowOffset = CGSizeMake(1, 0);
    revealController.delegate = self;
    _viewController = revealController;
    self.window.rootViewController = _viewController;
}

-(void)setStaticValues{
    if (![USERDEF boolForKey:kITS_SET_STATIC_VALUES]) {
        [USERDEF setBool:YES forKey:kITS_SET_STATIC_VALUES];
        [USERDEF setBool:YES forKey:kITS_ANY_SOUND];
        [USERDEF setBool:NO forKey:kNOTIFICATION_STATE];
        [USERDEF setInteger:1 forKey:kSELECTED_LANGUAGE];
        [USERDEF setValue:@"10:00" forKey:kSTART_TIME];
        [USERDEF setValue:@"18:00" forKey:kEND_TIME];
        [USERDEF setInteger:0 forKey:kSELECTED_SOUND];
        [USERDEF setInteger:2 forKey:kINTERVAL];
        [USERDEF setInteger:0 forKey:kWEIGHT_INTERVAL];
        [USERDEF setObject:[NSDate date] forKey:kLAST_UPDATE_WEIGHT];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm";
    }
}

#pragma mark    PickerViewContainerDelegate

-(void)containerView:(PickerContainerView *)view didSelectPicker:(int)index{
    if (view.tag == 201) {
        [USERDEF setInteger:index forKey:kSELECTED_LANGUAGE];
        TutorialViewController *tutViewController = [[TutorialViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *nc1 = [[UINavigationController alloc] initWithRootViewController:tutViewController];
        nc1.navigationBarHidden = YES;
        self.window.rootViewController = nc1;
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position{
    
    if (position == FrontViewPositionLeft) {
        AbstractViewController *frontController = [[(UINavigationController *)_viewController.frontViewController viewControllers] objectAtIndex:0];
        [frontController itShowTransparentView:NO];
    }
    else if (position == FrontViewPositionRight){
        AbstractViewController *frontController = [[(UINavigationController *)_viewController.frontViewController viewControllers] objectAtIndex:0];
        [frontController itShowTransparentView:YES];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    application.applicationIconBadgeNumber = 0;
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        InAppAlarmView *pickerContainer = (InAppAlarmView *)[self.window viewWithTag:544];
        if (!pickerContainer) {
            InAppAlarmView *pickerContainer = [[InAppAlarmView alloc] initWithFrame:self.window.bounds];
            pickerContainer.contentTitle = notification.alertBody;
            pickerContainer.tag  = 544;
            [self.window addSubview:pickerContainer];
            
            [pickerContainer showContentView];
        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bonaqua App"
//                                                        message:notification.alertBody
//                                                       delegate:self cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
    }
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
