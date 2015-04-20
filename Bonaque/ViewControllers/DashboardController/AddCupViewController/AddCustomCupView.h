//
//  AddCustomCupView.h
//  Bonaque
//
//  Created by Puujee on 4/16/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AbstractContainerView.h"

@protocol AddCustomCupViewDelegate <NSObject>

-(void)didFinishAddCup;

@end

@interface AddCustomCupView : AbstractContainerView{
    id<AddCustomCupViewDelegate>delegate;
}
@property (nonatomic, strong) id<AddCustomCupViewDelegate>delegate;
@end
