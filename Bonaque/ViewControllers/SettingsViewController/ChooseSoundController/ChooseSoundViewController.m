//
//  ChooseSoundViewController.m
//  Bonaque
//
//  Created by Puujee on 4/8/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "ChooseSoundViewController.h"

@interface ChooseSoundViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSInteger selectedRow;
}

@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ChooseSoundViewController
@synthesize itemArray = _itemArray;

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
//        [_tableView registerNib:[UINib nibWithNibName:@"SettingsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Дуу сонгох";
    [self showBackButton];
    selectedRow = [USERDEF integerForKey:kSELECTED_SOUND];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneSelecting)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    _itemArray = @[@"Standart", @"Water Sound", @"Drink Sound"];
    [self.view addSubview:self.tableView];
}

-(void)doneSelecting{
    [USERDEF setInteger:selectedRow forKey:kSELECTED_SOUND];
    [self.navigationController popViewControllerAnimated:YES];
    
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.textLabel.text = [_itemArray objectAtIndex:indexPath.row];
    if (indexPath.row == selectedRow)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    selectedRow = indexPath.row;
    if (indexPath.row == 1) {
        ATLog(@"sound");
        [Utils  playSystemSoundWithName:@"water_sound"];
    }
    else if (indexPath.row == 2){
        [Utils  playSystemSoundWithName:@"drink_sound"];
    }
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
