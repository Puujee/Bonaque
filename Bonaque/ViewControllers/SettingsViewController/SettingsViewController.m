//
//  SettingsViewController.m
//  Bonaque
//
//  Created by Puujee on 4/4/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsItem.h"  
#import "SettingsTableViewCell.h"
#import "PickerContainerView.h"
#import "DatePickerContainerView.h"
#import "ChooseSoundViewController.h"
#import "NormalSettingsTableViewCell.h"
#import <Crashlytics/Crashlytics.h>

@interface SettingsViewController ()<UITableViewDataSource, UITableViewDelegate, PickerContainerViewDelegate, DatePickerContainerViewDelegate >{
}


@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *itemArray;
@property(nonatomic, strong) NSArray *languageArray;
@property(nonatomic, strong) NSArray *soundsArray;
@property(nonatomic, strong) NSArray *intervalArray;

@end

@implementation SettingsViewController
@synthesize itemArray = _itemArray;
@synthesize languageArray = _languageArray;
@synthesize soundsArray = _soundsArray;
@synthesize intervalArray = _intervalArray;

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorColor = CLEAR_COLOR;
        //        _tableView.bounces = NO;
        _tableView.backgroundColor = CLEAR_COLOR;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_tableView registerNib:[UINib nibWithNibName:@"SettingsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:@"NormalSettingsTableViewCell" bundle:nil] forCellReuseIdentifier:@"normal_cell"];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenName = @"Settings";
    self.title = [LANGUAGE getStringForKey:@"settings"];
    [self.view addSubview:self.tableView];
    [self reloadLeftMenuItems];
}


-(void)reloadLeftMenuItems{
    _languageArray = [NSMutableArray arrayWithObjects:[LANGUAGE getStringForKey:@"en"], [LANGUAGE getStringForKey:@"mn"], nil];
    _soundsArray = [NSMutableArray arrayWithObjects:@"Стандарт дуу", @"Усны чимээ", @"Ус дугарах", nil];
    _intervalArray = [LANGUAGE getArrayForKey:@"interval_array"];

    NSMutableArray *tempArray = [NSMutableArray  array];
    {
        NSMutableArray *sectionArray = [NSMutableArray array];
//        NSString *languageDesc = [_languageArray objectAtIndex:[USERDEF integerForKey:kSELECTED_LANGUAGE]];
//        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"lang"] description:languageDesc itsHaveCheckBox:NO]];
        NSString *description = [LANGUAGE getStringForKey:@"disabled"];
        if ([USERDEF boolForKey:kITS_ANY_SOUND]) {
            description = [LANGUAGE getStringForKey:@"enabled"];
        }
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"app_sound"] description:description itsHaveCheckBox:YES]];
        [tempArray addObject:sectionArray];
    }
    
    {
        NSMutableArray *sectionArray = [NSMutableArray array];
        NSString *description = [LANGUAGE getStringForKey:@"disabled"];
        if ([USERDEF boolForKey:kNOTIFICATION_STATE]) {
            description = [LANGUAGE getStringForKey:@"enabled"];
        }
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"notification"] description:description itsHaveCheckBox:YES]];
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"start_time"] description:[USERDEF objectForKey:kSTART_TIME] itsHaveCheckBox:NO]];
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"end_time"] description:[USERDEF objectForKey:kEND_TIME] itsHaveCheckBox:NO]];
        
        NSString *selectedSound = @"Standart";
        if ([USERDEF integerForKey:kSELECTED_SOUND] == 1) {
            selectedSound = @"Water sound";
        }
        else if ([USERDEF integerForKey:kSELECTED_SOUND] == 2){
            selectedSound = @"Drink sound";
        }
        
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"notif_sound"] description:[_soundsArray objectAtIndex:[USERDEF integerForKey:kSELECTED_SOUND]] itsHaveCheckBox:NO]];
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"interval"] description:[_intervalArray objectAtIndex:[USERDEF integerForKey:kINTERVAL]] itsHaveCheckBox:NO]];

        [tempArray addObject:sectionArray];
    }
    {
        NSMutableArray *sectionArray = [NSMutableArray array];
        NSString *desc = [[LANGUAGE getArrayForKey:@"weight_reminder_interval"] objectAtIndex:[USERDEF integerForKey:kWEIGHT_INTERVAL]];
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"day_interval"] description:desc itsHaveCheckBox:NO]];
        [tempArray addObject:sectionArray];
    }
    {
        NSMutableArray *sectionArray = [NSMutableArray array];
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"share_bonaqua"] description:@"" itsHaveCheckBox:NO]];
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"rate_app"] description:@"" itsHaveCheckBox:NO]];
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"tw_follow"] description:@"" itsHaveCheckBox:NO]];
        [sectionArray addObject:[SettingsItem createItemWithTitle:@"Instagram Follow" description:@"" itsHaveCheckBox:NO]];
        [sectionArray addObject:[SettingsItem createItemWithTitle:[LANGUAGE getStringForKey:@"version"] description:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] itsHaveCheckBox:NO]];
//        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

        [tempArray addObject:sectionArray];
    }
    _itemArray = tempArray;
    [_tableView reloadData];
}

#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return _itemArray.count ;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_itemArray objectAtIndex:section] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 3 && indexPath.row < 4){
        NormalSettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normal_cell"];
        if (cell == nil) {
            cell = [[NormalSettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"normal_cell"] ;
        }
        SettingsItem *item = [[_itemArray objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row];
        cell.nameLabel.text = item.title;
        return cell;
    }
    SettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[SettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.item = [[_itemArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.isChecked = [USERDEF boolForKey:kITS_ANY_SOUND];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.isChecked = [USERDEF boolForKey:kNOTIFICATION_STATE];
        }
        else{
            cell.disableMode = ![USERDEF boolForKey:kNOTIFICATION_STATE];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self getHeaderLabeledView:[LANGUAGE getStringForKey:@"configuration"]];
    }
    else if (section == 1){
            return [self getHeaderLabeledView:[LANGUAGE getStringForKey:@"water_notif"]];
    }
    else if (section == 2){
        return [self getHeaderLabeledView:[LANGUAGE getStringForKey:@"config_weight"]];
    }
    else if (section == 3){
        return [self getHeaderLabeledView:[LANGUAGE getStringForKey:@"app"]];
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)] ;
    [headerView setBackgroundColor:[UIColor clearColor]];
    return headerView;
}

- (UIView *)getHeaderLabeledView:(NSString *)title{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.bounds.size.width, 30)] ;
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(15, 5, CGRectGetWidth(self.view.frame) - 30, 20)];
    label.font = [UIFont fontWithName:MAIN_LIGHT_FONT size:11.0f];
    label.textColor = MAIN_COLOR;
    label.text = [title uppercaseString];
    [headerView addSubview:label];
    
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetHeight(headerView.frame) - 1, CGRectGetWidth(self.view.frame) - 15, 1)];
    sepView.backgroundColor = MAIN_COLOR;
    [headerView addSubview:sepView];
    return headerView;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
//        if (indexPath.row == 0) {
//            PickerContainerView *pickerContainer = [[PickerContainerView alloc] initWithFrame:self.view.window.bounds];
//            pickerContainer.title = [LANGUAGE getStringForKey:@"choose_lang"];
//            pickerContainer.listArray = _languageArray;
//            pickerContainer.delegate = self;
//            pickerContainer.tag  = 201;
//            [self.view.window addSubview:pickerContainer];
//            [pickerContainer showContentView];
//        }
//        else if (indexPath.row == 1){
            SettingsItem *item = [[_itemArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            [USERDEF setBool:![USERDEF boolForKey:kITS_ANY_SOUND] forKey:kITS_ANY_SOUND];
            if ([USERDEF boolForKey:kITS_ANY_SOUND]) {
                item.description = [LANGUAGE getStringForKey:@"enabled"];
            }
            else{
                item.description = [LANGUAGE getStringForKey:@"disabled"];
            }
            [[_itemArray objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:item];
            [_tableView reloadData];
//        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SettingsItem *item = [[_itemArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            [USERDEF setBool:![USERDEF boolForKey:kNOTIFICATION_STATE] forKey:kNOTIFICATION_STATE];
            if ([USERDEF boolForKey:kNOTIFICATION_STATE]) {
                [Utils setAlarmSchedule];
                item.description = [LANGUAGE getStringForKey:@"enabled"];
            }
            else{
                [Utils removeLocalNotification:[LANGUAGE getStringForKey:@"notif_title"]];
                item.description = [LANGUAGE getStringForKey:@"disabled"];
            }
            [[_itemArray objectAtIndex:indexPath.section] replaceObjectAtIndex:indexPath.row withObject:item];
            [_tableView reloadData];
        }
        else{
            if ([USERDEF boolForKey:kNOTIFICATION_STATE]) {
                if (indexPath.row == 1) {
                    DatePickerContainerView *pickerContainer = [[DatePickerContainerView alloc] initWithFrame:self.view.window.bounds];
                    pickerContainer.tag = 105;
                    pickerContainer.title = [LANGUAGE getStringForKey:@"select_start_time"];
                    pickerContainer.delegate = self;
                    [self.view.window addSubview:pickerContainer];
                    
                    [pickerContainer showContentView];
                }
                else if (indexPath.row == 2){
                    DatePickerContainerView *pickerContainer = [[DatePickerContainerView alloc] initWithFrame:self.view.window.bounds];
                    pickerContainer.tag = 106;
                    pickerContainer.title = [LANGUAGE getStringForKey:@"select_end_time"];
                    pickerContainer.delegate = self;
                    [self.view.window addSubview:pickerContainer];
                    
                    [pickerContainer showContentView];
                }
                else if (indexPath.row == 3){
                    ChooseSoundViewController *soundViewController = [[ChooseSoundViewController alloc] initWithNibName:nil bundle:nil];
                    [self.navigationController pushViewController:soundViewController animated:YES];
                }
                else{
                    PickerContainerView *pickerContainer = [[PickerContainerView alloc] initWithFrame:self.view.window.bounds];
                    pickerContainer.title = [LANGUAGE getStringForKey:@"choose_interval"];
                    pickerContainer.listArray = _intervalArray;
                    pickerContainer.delegate = self;
                    pickerContainer.tag  = 202;
                    [self.view.window addSubview:pickerContainer];
                    
                    [pickerContainer showContentView];
                }
            }
        }
    }
    else if (indexPath.section == 2){
        PickerContainerView *pickerContainer = [[PickerContainerView alloc] initWithFrame:self.view.window.bounds];
        pickerContainer.title = [LANGUAGE getStringForKey:@"select_interval"];
        pickerContainer.listArray = [LANGUAGE getArrayForKey:@"weight_reminder_interval"];
        pickerContainer.delegate = self;
        pickerContainer.tag  = 302;
        [self.view.window addSubview:pickerContainer];
        [pickerContainer showContentView];
    }
    else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
            content.contentURL = [NSURL URLWithString:@"https://itunes.apple.com/us/app/bonaqua/id989085719?mt=8"];
            content.contentTitle =  [NSString stringWithFormat:@"Bonaqua: Ус уухыг сануулах аппликэйшн"];
            content.contentDescription  = @"GET IT ON APP STORE";
            content.imageURL = [NSURL URLWithString:MAIN_IMAGE_URL];
//            content.contentDescription = [NSString stringWithFormat:@"%@.", _item.content];
            [FBSDKShareDialog showFromViewController:self
                                         withContent:content
                                            delegate:nil];
//            SLComposeViewController *fbPost = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//            [fbPost setInitialText:[NSString stringWithFormat:@"Сайн уу, Bonaqua-г суулгаж үзээрэй.%@", ITUNES_DOWNLOAD_URL]];
//            [self presentViewController:fbPost animated:YES completion:nil];
//            
//            [fbPost setCompletionHandler:^(SLComposeViewControllerResult result) {
//                
//                
//                switch (result) {
//                    case SLComposeViewControllerResultCancelled:
//                        NSLog(@"Post Canceled");
//                        break;
//                    case SLComposeViewControllerResultDone:
//                        NSLog(@"Post Sucessful");
//                        break;
//                        
//                    default:
//                        break;
//                }
//                
//                [self dismissViewControllerAnimated:YES completion:nil];
//                
//            }];
        }
        else if (indexPath.row == 1){
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id989085719"]]) {
                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id989085719"]];
            }
        }
        else if (indexPath.row == 2){
            NSString *url = @"https://www.twitter.com/CocaColaMongol";
            NSString *encodedString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *URL = [NSURL URLWithString:encodedString];
            SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
            webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
            [[[APPDEL viewController] frontViewController]   presentViewController:webViewController animated:YES completion:nil];
        }
        else if (indexPath.row == 3){
            NSString *url = @"https://instagram.com/cocacolamongolia/";
            NSString *encodedString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *URL = [NSURL URLWithString:encodedString];
            SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:URL];
            webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
            [[[APPDEL viewController] frontViewController]   presentViewController:webViewController animated:YES completion:nil];
        }
    }
}

#pragma mark    PickerViewContainerDelegate

-(void)containerView:(PickerContainerView *)view didSelectPicker:(int)index{
    if (view.tag == 201) {
        if (index == [USERDEF integerForKey:kSELECTED_LANGUAGE]) {
            return;
        }
        [Utils removeLocalNotification:[LANGUAGE getStringForKey:@"notif_title"]];
        SettingsItem *item = [[_itemArray objectAtIndex:0] objectAtIndex:0];
        item.description = [_languageArray objectAtIndex:index];
        [USERDEF setInteger:index forKey:kSELECTED_LANGUAGE];
        [USERDEF synchronize];
        [self reloadLeftMenuItems];
        [Utils setAlarmSchedule];
        [[APPDEL rearViewController] reloadLeftMenuItems];
        [_tableView reloadData];
    }
    else if (view.tag == 202){
        SettingsItem *item = [[_itemArray objectAtIndex:1] objectAtIndex:4];
        item.description = [_intervalArray objectAtIndex:index];
        [USERDEF setInteger:index forKey:kINTERVAL];
        [[_itemArray objectAtIndex:1] replaceObjectAtIndex:4 withObject:item];
        [_tableView reloadData];
        [Utils setAlarmSchedule];
    }
    else if (view.tag == 302){
        SettingsItem *item = [[_itemArray objectAtIndex:2] objectAtIndex:0];
        item.description = [[LANGUAGE getArrayForKey:@"weight_reminder_interval"] objectAtIndex:index];
        [USERDEF setInteger:index forKey:kWEIGHT_INTERVAL];
        [[_itemArray objectAtIndex:2] replaceObjectAtIndex:0 withObject:item];
        [_tableView reloadData];
    }
}

-(void)containerView:(DatePickerContainerView *)view didSelectTime:(NSDate *)time {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlagsTime = NSCalendarUnitHour | NSCalendarUnitMinute ;

    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    if (view.tag == 105) {
        SettingsItem *item = [[_itemArray objectAtIndex:1] objectAtIndex:1];
        item.description = [dateFormatter stringFromDate:time];
        [USERDEF setValue:item.description forKey:kSTART_TIME];
        [[_itemArray objectAtIndex:1] replaceObjectAtIndex:1 withObject:item];
        [_tableView reloadData];
        [Utils setAlarmSchedule];
    }
    else if (view.tag == 106){
        NSDateComponents *dateComponents = [gregorian components:unitFlagsTime fromDate:time];
        NSDateComponents *timeComponents = [gregorian components:unitFlagsTime fromDate:[Utils dateFromHouurs:[USERDEF valueForKey:kSTART_TIME]]];
        if (dateComponents.hour <= timeComponents.hour) {
            [Utils showAlert:@"Та эхлэх цагаас хойших цагаар тааруулах боломжтой."];
            return;
        }
        SettingsItem *item = [[_itemArray objectAtIndex:1] objectAtIndex:2];
        item.description = [dateFormatter stringFromDate:time];
        [USERDEF setValue:item.description forKey:kEND_TIME];
        [[_itemArray objectAtIndex:1] replaceObjectAtIndex:2 withObject:item];
        [_tableView reloadData];
        [Utils setAlarmSchedule];
    }
}

-(void)viewWillAppear:(BOOL)animated    {
    SettingsItem *item = [[_itemArray objectAtIndex:1] objectAtIndex:3];
    item.description = [_soundsArray objectAtIndex:[USERDEF integerForKey:kSELECTED_SOUND]];
    [[_itemArray objectAtIndex:1] replaceObjectAtIndex:3 withObject:item];
    [_tableView reloadData];
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
