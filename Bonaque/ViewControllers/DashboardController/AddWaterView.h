//
//  AddWaterView.h
//  Bonaque
//
//  Created by Puujee on 4/12/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AbstractContainerView.h"

@protocol  AddWaterViewDelegate <NSObject>

-(void)addedWaterLitre:(float)water;

@end

@interface AddWaterView : AbstractContainerView{
    id<AddWaterViewDelegate>delegate;
    int selectedIndex;
    BOOL selected;
}

@property (nonatomic, strong) id<AddWaterViewDelegate>delegate;

-(void)didFinishHide;

@end
