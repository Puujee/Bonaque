//
//  ToastView.h
//  Bonaque
//
//  Created by Puujee on 4/20/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)();

@interface UIView (Toast)


- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position undoButton:(void(^)(void))tapCallback;

- (void)toastUndoButtonClicked;

@end
