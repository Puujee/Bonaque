//
//  UpdateWeightView.h
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AbstractContainerView.h"

@protocol UpdateWeightViewDelegate <NSObject>

-(void)didFinishUpdateWeight;

@end

@interface UpdateWeightView : AbstractContainerView{
    id<UpdateWeightViewDelegate>delegate;
}

@property (nonatomic, strong) id<UpdateWeightViewDelegate>delegate;

@end
