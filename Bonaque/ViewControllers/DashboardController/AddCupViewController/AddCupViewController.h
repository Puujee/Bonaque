//
//  AddCupViewController.h
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AbstractViewController.h"

@protocol AddCupViewControllerDelegate <NSObject>

-(void)addCupCompleted:(Cup *)cup;

@end

@interface AddCupViewController : AbstractViewController{
    id<AddCupViewControllerDelegate> delegate;
}
@property (nonatomic, strong) id<AddCupViewControllerDelegate> delegate;

@end
