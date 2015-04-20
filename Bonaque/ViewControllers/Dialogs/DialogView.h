//
//  DialogView.h
//  Bonaque
//
//  Created by Puujee on 4/18/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kCongrulateDialog,
    kWarningDialog,
    kSuperWarningDialog,
    
} DialogType;


@interface DialogView : UIView{
}

@property (nonatomic, assign) DialogType type;


-(void)showContentView;
-(void)goBack;

@end
