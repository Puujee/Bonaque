//
//  AdviceDetailView.h
//  Bonaque
//
//  Created by Puujee on 4/20/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AbstractContainerView.h"

@interface AdviceDetailView : AbstractContainerView

@property (nonatomic, strong) Purpose *item;
@property (nonatomic, strong) UIViewController *mainViewController;

@end
