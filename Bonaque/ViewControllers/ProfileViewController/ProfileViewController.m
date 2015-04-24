//
//  ProfileViewController.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileTableViewCell.h"
#import "ProfileItem.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface ProfileViewController ()<UITableViewDataSource, UITableViewDelegate>{
    UIButton *fbButton;
    UIImageView *profileImageView;
    UIButton *profileButton;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemArray;

@end

@implementation ProfileViewController

@synthesize itemArray = _itemArray;

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = CLEAR_COLOR;
        //        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_tableView registerNib:[UINib nibWithNibName:@"ProfileTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        {
            Person *user = [DATABASE getUser];
            
            UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 150)];
            tableHeaderView.backgroundColor = [UIColor yellowColor];
            _tableView.tableHeaderView = tableHeaderView;
            
            UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:tableHeaderView.bounds];
            bgImageView.image = [UIImage imageNamed:@"img_profile_back"];
            [tableHeaderView addSubview:bgImageView];
            
            {
                profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 90)];
                [profileImageView.layer setCornerRadius:45];
                profileImageView.clipsToBounds  = YES;
                //            profileImageView.center = CGPointMake(tableHeaderView.center.x, tableHeaderView.center.y - 20);
                [profileImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
                [profileImageView.layer setBorderWidth:2];
                if (user.gender.intValue == 1) {
                    profileImageView.image = [UIImage imageNamed:@"img_man"];
                }
                else{
                    profileImageView.image = [UIImage imageNamed:@"img_woman"];
                }
                if (user.img_url.length > 0) {
                    [profileImageView setImageWithURL:[NSURL URLWithString:user.img_url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                }
                profileImageView.backgroundColor = [UIColor grayColor];
                [tableHeaderView addSubview:profileImageView];
                
                profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [profileButton setContentMode:UIViewContentModeCenter];
                [profileButton addTarget:self action:@selector(signUpFacebook) forControlEvents:UIControlEventTouchUpInside];
                profileButton .frame = CGRectMake(10, 10, 90, 90);
                [tableHeaderView addSubview:profileButton];
            }
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(profileButton.frame) + 10, 20, CGRectGetWidth(self.view.frame) - (CGRectGetMaxX(profileButton.frame) + 10), 40)];
            titleLabel.textAlignment = NSTextAlignmentLeft;
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
            titleLabel.backgroundColor = CLEAR_COLOR;
            titleLabel.numberOfLines = 99;
            titleLabel.text = user.name;
            titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            titleLabel.textColor = [UIColor whiteColor];
            [tableHeaderView addSubview:titleLabel];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(profileButton.frame) + 10, CGRectGetMaxY(titleLabel.frame), CGRectGetWidth(self.view.frame) - (CGRectGetMaxX(profileButton.frame) + 10), 20)];
            label.textAlignment = NSTextAlignmentLeft;
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
            NSString *gender = [LANGUAGE getStringForKey:@"female"];
            if (user.gender.intValue == 1) {
                gender = [LANGUAGE getStringForKey:@"male"];
            }
            label.text = [NSString stringWithFormat:@"%@ %@   |   %@ %@ ", user.weight, [LANGUAGE getStringForKey:@"kg"], user.height, [LANGUAGE getStringForKey:@"cm"] ];
            label.backgroundColor = CLEAR_COLOR;
            label.numberOfLines = 99;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.textColor = [UIColor whiteColor];
            [tableHeaderView addSubview:label];
            
            
            {
                UIScrollView *purposeView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(profileImageView.frame) + 5, CGRectGetWidth(self.view.frame), 40)];
                purposeView.showsVerticalScrollIndicator = NO;
                purposeView.showsHorizontalScrollIndicator = NO;
                purposeView.bounces = NO;
                purposeView.backgroundColor = [UIColor clearColor];
                [tableHeaderView addSubview:purposeView];
                
                float width = 30;
                float margin = 10;
                
                NSArray *completedPurposes = [DATABASE getWinnedPurpose];
                if (completedPurposes.count > 0) {
                    for (Purpose *purpose in completedPurposes) {
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, 5, width, width)];
                        imageView.image = [UIImage imageNamed:[NSString  stringWithFormat:@"%@_achived", purpose.icon]];
                        [purposeView addSubview:imageView ];
                        margin += width + 10;
                    }
                    purposeView.contentSize = CGSizeMake(margin, 40);
                }
                else{
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.view.frame), 40)];
                    label.textAlignment = NSTextAlignmentLeft;
                    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
                    label.text = @"Та одоогоор цол аваагүй байна.";
                    label.backgroundColor = CLEAR_COLOR;
                    label.numberOfLines = 1;
                    label.lineBreakMode = NSLineBreakByWordWrapping;
                    label.textColor = [UIColor whiteColor];
                    [purposeView addSubview:label];
                }
         
            }
            //            fbButton = [UIButton buttonWithType:UIButtonTypeCustom];
//            [fbButton setBackgroundImage:[HXColor imageWithColor:UIColorFromRGB(0x394979)] forState:UIControlStateNormal];
//            fbButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 130, CGRectGetHeight(tableHeaderView.frame) - 50, 120, 40);
//            fbButton.clipsToBounds = YES;
//            [fbButton.layer setBorderColor:UIColorFromRGB(0x34548a).CGColor];
//            [fbButton.layer setBorderWidth:1];
//            [fbButton setImage:[UIImage imageNamed:@"ic_login_fb"] forState:UIControlStateNormal];
//            [fbButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
//            [fbButton.titleLabel setFont:[UIFont fontWithName:MAIN_LIGHT_FONT size:11]];
//            if (user.img_url.length > 0) {
//                [profileImageView setImageWithURL:[NSURL URLWithString:user.img_url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//                [profileImageView.layer setBorderWidth:1];
//                [profileImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
//                [fbButton addTarget:self action:@selector(logOutFacebook) forControlEvents:UIControlEventTouchUpInside];
//                [fbButton setTitle:@"Гарах" forState:UIControlStateNormal];
//            }
//            else{
//                [fbButton addTarget:self action:@selector(signUpFacebook) forControlEvents:UIControlEventTouchUpInside];
//                [fbButton setTitle:@"Фэйсбүүкээр нэвтрэх" forState:UIControlStateNormal];
//            }
//            [tableHeaderView addSubview:fbButton];
        }
    }
    return _tableView;
}

//-(void)temp{
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenName = @"Profile";
    self.title  = @"Bonaqua";
    NSMutableArray *tempArray = [NSMutableArray array];
    {
        ProfileItem *item = [[ProfileItem alloc] init];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yy/MM/dd";
        NSDate *firstDate = [USERDEF objectForKey:kFIRST_DATE];
        item.title = [dateFormatter stringFromDate:firstDate];
        item.desc = [LANGUAGE getStringForKey:@"profile_1"];
        item.colour = UIColorFromRGB(0x1875b2);
        item.icon = @"ic_profile_start";
        [tempArray addObject:item];
    }
    {
        ProfileItem *item = [[ProfileItem alloc] init];
        item.title = [NSString stringWithFormat:@"%.1f", [DATABASE getAllDrinkedWater]/ML];
        item.desc = [LANGUAGE getStringForKey:@"profile_2"];
        item.colour = UIColorFromRGB(0x3fbbd7);
        item.icon = @"ic_profile_total";
        [tempArray addObject:item];
    }
    {
        ProfileItem *item = [[ProfileItem alloc] init];
        item.title = [NSString stringWithFormat:@"%.1f", [DATABASE getAverageDrinkedWater]/ML];
        item.desc = [LANGUAGE getStringForKey:@"profile_3"];
        item.colour = UIColorFromRGB(0x0b86b0);
        item.icon = @"ic_profile_daily";
        [tempArray addObject:item];
    }
    {
        ProfileItem *item = [[ProfileItem alloc] init];
        item.title = [NSString stringWithFormat:@"%.1f", [DATABASE getMaximumWeight]];
        item.desc = [LANGUAGE getStringForKey:@"profile_4"];
        item.colour = UIColorFromRGB(0x72a5c2);
        item.icon = @"ic_profile_max";
        [tempArray addObject:item];
    }
    {
        ProfileItem *item = [[ProfileItem alloc] init];
        item.title = [NSString stringWithFormat:@"%.1f", [DATABASE getMinimumWeight]];
        item.desc = [LANGUAGE getStringForKey:@"profile_5"];
        item.colour = UIColorFromRGB(0x3aaad2);
        item.icon = @"ic_profile_min";
        [tempArray addObject:item];
    }
    _itemArray = tempArray;
    
    [self.view addSubview:self.tableView];
  
}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[ProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.item = [_itemArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    AdviceDetailViewController *viewController = [[AdviceDetailViewController alloc] initWithNibName:nil bundle:nil];
//    viewController.item = [_itemArray objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:viewController animated:YES];
    
}

-(void)signUpFacebook{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (![FBSDKAccessToken currentAccessToken]) {
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (error) {
                // Process error
            } else if (result.isCancelled) {
                // Handle cancellations
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if ([result.grantedPermissions containsObject:@"email"]) {
                    // Do work
                    ATLog(@"%@", result);
                    [FBSDKAccessToken setCurrentAccessToken:result.token];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self signUpFacebook];
                    //                    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
                    //                        // TODO: publish content.
                    //                        [self signUpFacebook];
                    //                    } else {
                    //                        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
                    //                        [loginManager logInWithPublishPermissions:@[@"publish_actions"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                    //                            //TODO: process error or result.
                    //                            [self signUpFacebook];
                    //                        }];
                    //                    }
                }
            }
        }];
        return;
    }
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSLog(@"Result:%@", result);
             [fbButton setTitle:@"Гарах" forState:UIControlStateNormal];
             [fbButton removeTarget:self action:@selector(signUpFacebook) forControlEvents:UIControlEventTouchUpInside];
             [fbButton addTarget:self action:@selector(logOutFacebook) forControlEvents:UIControlEventTouchUpInside];
             
             Person *user = [DATABASE getUser];
             user.img_url = [NSString stringWithFormat:@"https://graph.facebook.com/\%@/picture?width=340&height=340", result[@"id"]];
             if (user.img_url.length > 0) {
                 [profileImageView setImageWithURL:[NSURL URLWithString:user.img_url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
                 [profileImageView.layer setBorderWidth:1];
                 [profileImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
             }
             NSError *error = nil;
             if (![DATABASE.personFetchedResultController   performFetch:&error]) {
                 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                 abort();
             }
             [DATABASE saveChanges];
//             [self goSignUpController:result];
         }
     }];
}

-(void)logOutFacebook{
    [FBSDKAccessToken setCurrentAccessToken:nil];
    Person *user = [DATABASE getUser];
    user.img_url = @"";
    self.title = user.name;
    if (user.gender.intValue == 1) {
        profileImageView.image = [UIImage imageNamed:@"img_man"];
    }
    else{
        profileImageView.image = [UIImage imageNamed:@"img_woman"];
    }
    [fbButton setTitle:@"Фэйсбүүкээр нэвтрэх" forState:UIControlStateNormal];
    [fbButton removeTarget:self action:@selector(logOutFacebook) forControlEvents:UIControlEventTouchUpInside];
    [fbButton addTarget:self action:@selector(signUpFacebook) forControlEvents:UIControlEventTouchUpInside];
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
