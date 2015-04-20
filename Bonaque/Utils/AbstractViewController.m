//
//  AbstractViewController.m
//  DentalClinic
//
//  Created by Puujee on 3/30/15.
//  Copyright (c) 2015 CronoSoft Ltd. All rights reserved.
//

#import "AbstractViewController.h"

@interface AbstractViewController ()
{
    UIView *transparentView;

}
@end

@implementation AbstractViewController
@synthesize isNavigation = _isNavigation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BG_COLOR;

    if(!_isNavigation)
    {
        
        SWRevealViewController *revealController = [self revealViewController];
        [revealController tapGestureRecognizer];
        [revealController panGestureRecognizer];
        
        UIButton *revealButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [revealButton setImage:[UIImage imageNamed:@"ic_menu"] forState:UIControlStateNormal];
        revealButton.frame = CGRectMake(0, 0, 30, 44);
        
        [revealButton addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *revealBarbutton = [[UIBarButtonItem alloc] initWithCustomView:revealButton];
        self.navigationItem.leftBarButtonItem = revealBarbutton;
    }
    else{
        self.revealViewController.panGestureRecognizer.enabled=NO;
    }
    
    transparentView = [[UIView alloc] initWithFrame:self.view.bounds];
    transparentView.hidden = NO;
    transparentView.alpha = 0;
    transparentView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7f];
    [self.view addSubview:transparentView];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!_isNavigation)
    {
        self.revealViewController.panGestureRecognizer.enabled=YES;

    }
    else{
        self.revealViewController.panGestureRecognizer.enabled=NO;
    }
}

-(void)setIsNavigation:(BOOL)isNavigation{
    _isNavigation = isNavigation;
    if (_isNavigation) {
        [self     showBackButton];
    }
}

-(void)itShowTransparentView:(BOOL)isShow{
    [self.view bringSubviewToFront:transparentView];
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (isShow) {
            transparentView.alpha = 1.0f;
        }
        else{
            transparentView.alpha = 0.f;
        }
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showBackButton{
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 44)];
    [backButton  setImage:[UIImage imageNamed:@"ic_nav_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = back;
    //    titleLabel.frame = CGRectMake(0, 0, 280, 40);
    self.navigationItem.rightBarButtonItems = nil;
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)drawShadow
{
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.layer.shadowOpacity = 0.8;
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(0, 0);
    self.navigationController.navigationBar.layer.shadowRadius = 3;
    self.navigationController.navigationBar.layer.masksToBounds = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay
{
    block = [block copy] ;
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
