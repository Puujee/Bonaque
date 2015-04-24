//
//  PurposeViewController.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "PurposeViewController.h"
#import "PurposeTableViewCell.h"

@interface PurposeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemArray;

@end

@implementation PurposeViewController
@synthesize itemArray = _itemArray;

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
         _tableView.separatorColor = CLEAR_COLOR;
        //        _tableView.bounces = NO;
        _tableView.backgroundColor = CLEAR_COLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_tableView registerNib:[UINib nibWithNibName:@"PurposeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenName = @"Purpose";
    self.title = [[LANGUAGE getArrayForKey:@"menus"] objectAtIndex:3];
    _itemArray = [DATABASE getpurposeLanguageArray];
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
    
    PurposeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[PurposeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.item = [_itemArray objectAtIndex:indexPath.row];
    cell.isLast = NO;
    cell.isFirst = NO;
    if (indexPath.row == 0) {
        cell.isFirst = YES;
    }
    else if(indexPath.row == _itemArray.count - 1){
        cell.isLast = YES;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [Utils showAlert:[NSString stringWithFormat:@"", ]];
    Purpose *item = [_itemArray objectAtIndex:indexPath.row];
    PurposeLog *purposeLog = [DATABASE getPurposeLogWithID:item.purposeID.intValue];
    if (purposeLog) {
        if (purposeLog.daysRemaining.intValue == 0) {
            FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
            content.contentURL = [NSURL URLWithString:ITUNES_DOWNLOAD_URL];
            content.contentTitle =  [NSString stringWithFormat:@"%@ цол авлаа.", item.title];
            content.contentDescription = [NSString stringWithFormat:@"%@ өдөр ус уув.", item.days];
            content.imageURL = [NSURL URLWithString:MAIN_IMAGE_URL];
            [FBSDKShareDialog showFromViewController:self
                                         withContent:content
                                            delegate:nil];
        }
    }
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
