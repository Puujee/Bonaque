//
//  ChangeLanguageViewController.m
//  Bonaque
//
//  Created by Puujee on 4/15/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "ChangeLanguageViewController.h"
#import "UIImage+AssetLaunchImage.h"
#import "TutorialViewController.h"

@interface ChangeLanguageViewController (){
        UIImageView *imageView;
}
@end

@implementation ChangeLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:   animated];
    [self.navigationController setNavigationBarHidden:YES];
    [self getConfigure];
}

-(void)getConfigure{
    imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.backgroundColor = [UIColor blackColor];
    // we're an iPhone or iPod touch. No rotation for you.
    
    // are we a 3.5in? or a 4?
    [imageView setFrame: self.view.bounds];
    imageView.image = [UIImage assetLaunchImage];
    float buttonHeight = 50;
    float margin   = 30;
    float bottomMargin = 100;

    if ([UIScreen  isiPhone5])
    {
        // 4 inch iPhone 5
        buttonHeight = 40;
    }
    else if ([UIScreen isiPhone4]){
        buttonHeight = 40;
        bottomMargin = 70;
    }
    else if([UIScreen  isiPhone6]){
        margin = 45;
    }
    else if ([UIScreen  isiPhone6Plus]){
        margin = 45;
    }
    [self.view addSubview:imageView];
    [self.view bringSubviewToFront:imageView];
    {
        UIButton *fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [fbButton setBackgroundImage:[HXColor imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        fbButton.frame = CGRectMake(margin, CGRectGetHeight(self.view.frame) - bottomMargin - buttonHeight*2, CGRectGetWidth(self.view.frame) -  margin*2, buttonHeight);
        fbButton.clipsToBounds = YES;
        [fbButton.layer setCornerRadius:3];
        [fbButton setImage:[UIImage imageNamed:@"flag_en"] forState:UIControlStateNormal];
        [fbButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        fbButton.tag  = 100;
        [fbButton addTarget:self action:@selector(selectLanguage:) forControlEvents:UIControlEventTouchUpInside];
        [fbButton.titleLabel setFont:[UIFont fontWithName:MAIN_LIGHT_FONT size:15]];
        [fbButton setTitle:[@"English" uppercaseString] forState:UIControlStateNormal];
        [fbButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:fbButton];
    }
    {
        UIButton *fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [fbButton setBackgroundImage:[HXColor imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        fbButton.frame = CGRectMake(margin, CGRectGetHeight(self.view.frame) - bottomMargin + 10 - buttonHeight, CGRectGetWidth(self.view.frame) -  margin*2, buttonHeight);
        fbButton.clipsToBounds = YES;
        fbButton.tag = 101;
        [fbButton.layer setCornerRadius:3];
        [fbButton setImage:[UIImage imageNamed:@"flag_mn"] forState:UIControlStateNormal];
        [fbButton setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [fbButton addTarget:self action:@selector(selectLanguage:) forControlEvents:UIControlEventTouchUpInside];
        [fbButton.titleLabel setFont:[UIFont fontWithName:MAIN_LIGHT_FONT size:15]];
        [fbButton setTitle:[@"Монгол" uppercaseString] forState:UIControlStateNormal];
        [fbButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:fbButton];
    }
}

-(void)selectLanguage:(id)sender{
    UIButton *button = (UIButton *)sender;
    [USERDEF setInteger:button.tag - 100 forKey:kSELECTED_LANGUAGE];
    TutorialViewController *tutViewController = [[TutorialViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:tutViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
