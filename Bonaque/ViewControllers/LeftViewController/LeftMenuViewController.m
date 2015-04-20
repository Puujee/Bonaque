//
//  LeftViewController.m
//  Bonaque
//
//  Created by Puujee on 4/4/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "MenuItem.h"
#import "MenuTableViewCell.h"
#import "SettingsViewController.h"
#import "DashboardViewController.h"
#import "AdviceViewController.h"
#import "ChartViewController.h"
#import "PurposeViewController.h"
#import "ProfileViewController.h"
#import <UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface LeftMenuViewController () <UITableViewDataSource, UITableViewDelegate>{
    BOOL isTopControllerProfile;
    UIImageView *userImageView;
    UIButton  *titleButton;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *itemArray;

@end

@implementation LeftMenuViewController
@synthesize selectedIndexPath;
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
        [_tableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:@"AboutTableViewCell" bundle:nil] forCellReuseIdentifier:@"aboutCell"];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BG_COLOR;
//    UIImageView *imageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 40, CGRectGetHeight(self.view.bounds))];
//    imageVIew.image = [UIImage imageNamed:@"left_menu_back"];
//    [self.view addSubview:imageVIew];
    
    [self.view addSubview:self.tableView];
    [self reloadLeftMenuItems];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[_tableView reloadData];
    [_tableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    Person *user = [DATABASE getUser];
    if (user.gender.intValue == 1) {
        userImageView.image = [UIImage imageNamed:@"img_man"];
    }
    else{
        userImageView.image = [UIImage imageNamed:@"img_woman"];
    }
    if (user.img_url.length > 0) {
        [userImageView setImageWithURL:[NSURL URLWithString:user.img_url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [userImageView.layer setBorderWidth:1];
        [userImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [userImageView.layer setCornerRadius:25];
    }
    [titleButton setTitle:[NSString stringWithFormat:@"%@", user.name] forState:UIControlStateNormal];

}


-(void)reloadLeftMenuItems{
    NSMutableArray *sectionArray = [NSMutableArray array];
    NSArray *array = @[@"ic_menu_home",@"ic_menu_graphic",@"ic_menu_advice",@"ic_menu_purpose",@"ic_menu_settings"];
    int i = 0;
    for (NSString *menuName in [LANGUAGE getArrayForKey:@"menus"]) {
        [sectionArray addObject:[MenuItem createItemWithTitle:menuName imageName:[array objectAtIndex:i]]];
        i++;
    }
    [self createHeaderView];
    selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    _itemArray = sectionArray;
    [_tableView reloadData];
}

-(void)createHeaderView{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 40, 100)];
    headerView.backgroundColor = CLEAR_COLOR;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:headerView.bounds];
    imageView.image = [UIImage imageNamed:@"img_profile_back"];
    [headerView addSubview:imageView];
    
    Person *user = [DATABASE getUser];
    
    
    userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 50 , 50)];
    userImageView.image = [UIImage imageNamed:@"img_default"];
    userImageView.clipsToBounds = YES;
//    userImageView.backgroundColor = [UIColor grayColor];
    userImageView.contentMode = UIViewContentModeScaleAspectFill;
    if (user.gender.intValue == 1) {
        userImageView.image = [UIImage imageNamed:@"img_man"];
    }
    else{
        userImageView.image = [UIImage imageNamed:@"img_woman"];
    }
    if (user.img_url.length > 0) {
        [userImageView setImageWithURL:[NSURL URLWithString:user.img_url] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [userImageView.layer setBorderWidth:1];
        [userImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [userImageView.layer setCornerRadius:25];
    }
    [headerView addSubview:userImageView];
    
    float leftMargin = 80;
    
    if ([UIScreen isiPhone6]) {
        leftMargin = 110;
    }
    else if ([UIScreen isiPhone6Plus]){
        leftMargin = 150;
    }
    
    titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame = CGRectMake(CGRectGetMaxX(userImageView.frame) + 10, 30, CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(userImageView.frame) - 20 - leftMargin, 50);
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    titleButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
    titleButton.titleLabel.numberOfLines = 2;
    [titleButton setImage:[UIImage imageNamed:@"ic-rightarrow"] forState:UIControlStateNormal];
    [titleButton setImageEdgeInsets:UIEdgeInsetsMake(10, CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(userImageView.frame) - leftMargin - 40, 10, 0)];
//    titleButton.backgroundColor = [UIColor redColor];
    titleButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    titleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [titleButton setTitle:[NSString stringWithFormat:@"%@", user.name] forState:UIControlStateNormal];
//    titleButton.userInteractionEnabled = NO;
    [titleButton addTarget:self action:@selector(clickUserName) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:titleButton];
    
//    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 60, CGRectGetWidth(self.view.frame) - 110, 30)];
//    descriptionLabel.backgroundColor = CLEAR_COLOR;
//    descriptionLabel.numberOfLines = 999;
//    descriptionLabel.textColor = [UIColor whiteColor];
//    descriptionLabel.textAlignment = NSTextAlignmentLeft;
//    descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
//    descriptionLabel.text = [NSString stringWithFormat:@"%@см, %@кг", user.height, user.weight];
//    [headerView addSubview:descriptionLabel];
    _tableView.tableHeaderView = headerView;
}

-(void)clickUserName{
    [_tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
    selectedIndexPath = nil;
    SWRevealViewController *revealController = self.revealViewController;
    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    if (!isTopControllerProfile) {
        ProfileViewController *newViewController = [[ProfileViewController alloc] initWithNibName:nil bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
        [revealController pushFrontViewController:navigationController animated:YES];
        isTopControllerProfile = YES;
    }

}


#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.item = [_itemArray objectAtIndex:indexPath.row];
    cell.badgeView.hidden = YES;
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 1) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 1)];
    view.backgroundColor = UIColorFromRGB(0xe5e5e5);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (_itemArray.count <= indexPath.section) {
//        return 50;
//    }
    return 44;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SWRevealViewController *revealController = self.revealViewController;
    [revealController setFrontViewPosition:FrontViewPositionLeft animated:YES];
    isTopControllerProfile = NO;
    
    if (indexPath == selectedIndexPath) {
        return;
    }
    
    if (indexPath.section == 0) {
        selectedIndexPath = indexPath;
        if (indexPath.row == 0) {
            DashboardViewController *newViewController = [[DashboardViewController alloc] initWithNibName:nil bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
            navigationController.navigationBar.translucent = NO;
            
            [revealController pushFrontViewController:navigationController animated:YES];
        }
        else if (indexPath.row == 1) {
            ChartViewController *newViewController = [[ChartViewController alloc] initWithNibName:nil bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
            navigationController.navigationBar.translucent = NO;
            
            [revealController pushFrontViewController:navigationController animated:YES];
        }
        else if (indexPath.row == 2) {
            AdviceViewController *newViewController = [[AdviceViewController alloc] initWithNibName:nil bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
            navigationController.navigationBar.translucent = NO;
            
            [revealController pushFrontViewController:navigationController animated:YES];
        }
        else if (indexPath.row == 3){
            PurposeViewController *newViewController = [[PurposeViewController alloc] initWithNibName:nil bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
            navigationController.navigationBar.translucent = NO;
            
            [revealController pushFrontViewController:navigationController animated:YES];
        }
        else if (indexPath.row == 4){
            SettingsViewController *newViewController = [[SettingsViewController alloc] initWithNibName:nil bundle:nil];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newViewController];
            navigationController.navigationBar.translucent = NO;
            
            [revealController pushFrontViewController:navigationController animated:YES];
        }
    }
    //    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    //    [revealController pushFrontViewController:navigationController animated:YES];
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
