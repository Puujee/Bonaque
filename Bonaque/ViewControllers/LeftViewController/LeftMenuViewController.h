//
//  LeftViewController.h
//  Bonaque
//
//  Created by Puujee on 4/4/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

-(void)reloadLeftMenuItems;

@end
