//
//  AddUserViewController.m
//  Bonaque
//
//  Created by Puujee on 4/8/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AddUserViewController.h"

@interface AddUserViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, BSKeyboardControlsDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (nonatomic, strong) NSArray *cellArray;

@end

@implementation AddUserViewController
@synthesize itemArray = _itemArray;
@synthesize keyboardControls;
@synthesize cellArray;

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = MAIN_COLOR;
        _tableView.separatorColor = CLEAR_COLOR;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        {
            float headerHeight = 200;
            if ([UIScreen isiPhone4]) {
                headerHeight = 150;
            }
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), headerHeight)];
            headerView.backgroundColor = CLEAR_COLOR;
            _tableView.tableHeaderView = headerView;
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(self.view.frame), CGRectGetHeight(headerView.frame) - 60)];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.image = [UIImage imageNamed:@"logo_big"];
            [headerView addSubview:imageView];
        }
        {
            UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 70)];
            footerView.backgroundColor = CLEAR_COLOR;
            _tableView.tableFooterView = footerView;
            
            UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [skipButton setImage:[UIImage imageNamed:@"add-btn"] forState:UIControlStateNormal];
            [skipButton setImageEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 0)];
            skipButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [skipButton setBackgroundImage:[HXColor imageWithColor:UIColorFromRGB(0xeceff1)] forState:UIControlStateNormal];
            [skipButton.layer setCornerRadius:4];
            skipButton.clipsToBounds = YES;
            [skipButton setTitle:[[LANGUAGE getStringForKey:@"start"] uppercaseString] forState:UIControlStateNormal];
            [skipButton setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
            skipButton.titleLabel.font = [UIFont systemFontOfSize:14];
            skipButton.frame = CGRectMake(25, 10, (CGRectGetWidth(self.view.frame) - 50), 50);
            [skipButton addTarget:self action:@selector(setupUser) forControlEvents:UIControlEventTouchUpInside];
            [footerView addSubview:skipButton];
        }
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BG_COLOR;
    self.navigationItem.hidesBackButton = NO;
    [self.view addSubview:self.tableView];
    [self createItems];
    
    [Utils removeAllLocalNotification];
}

-(void)createItems{
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObject:[TextFieldedCellItem createItemWithTitle:[LANGUAGE getStringForKey:@"name"] imageName:@"home"]];
    [tempArray addObject:[TextFieldedCellItem createItemWithTitle:[LANGUAGE getStringForKey:@"height"] imageName:@"email"]];
    [tempArray addObject:[TextFieldedCellItem createItemWithTitle:[LANGUAGE getStringForKey:@"weight"] imageName:@"about"]];
    _itemArray = tempArray;
    [self buildCell];
    [_tableView reloadData];
}

- (TextFieldedCell *) getTextFieldedCell {
    static NSString *CellIdentifier = @"ActivityCell";
    TextFieldedCell *cell = [[TextFieldedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.contentView.backgroundColor = CLEAR_COLOR;
    cell.textLabel.font = [UIFont systemFontOfSize:13.f];
    cell.textLabel.textColor = UIColorFromRGB(0x636466);
    return cell;
}

- (CheckBoxCell *) getNewCheckBoxCell {
    //layout cell
    CheckBoxCell *cell = [[CheckBoxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = CLEAR_COLOR;
    cell.contentView.backgroundColor = CLEAR_COLOR;
    cell.backgroundView.backgroundColor = CLEAR_COLOR;
    return cell;
}


-(void)buildCell{
    NSMutableArray *textFieldsArray = [NSMutableArray array];
    {
        NSMutableArray *cellTempArray = [NSMutableArray array];
        {
            TextFieldedCell *cell = [self getTextFieldedCell];
            cell.item = [_itemArray objectAtIndex:0];
            cell.isFirst = YES;
            cell.valueTextField.delegate = self;
            cell.valueTextField.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            //            cell.valueTextField.placeHolderTextColor = [UIColor grayColor];
            [textFieldsArray addObject:cell.valueTextField];
            [cellTempArray addObject:cell];
        }
        {
            CheckBoxCell *cell = [self getNewCheckBoxCell];
            cell.isFirst = YES;
            cell.isLast = YES;
            cell.checkBoxValues = @[[LANGUAGE getStringForKey:@"male"], [LANGUAGE getStringForKey:@"female"]];
            //            cell.valueTextField.placeHolderTextColor = [UIColor grayColor];
            [cellTempArray addObject:cell];
        }
        {
            TextFieldedCell *cell = [self getTextFieldedCell];
            cell.item = [_itemArray objectAtIndex:1];
            cell.valueTextField.delegate = self;
            cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
            cell.valueTextField.indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
            //            cell.valueTextField.placeHolderTextColor = [UIColor grayColor];
            [textFieldsArray addObject:cell.valueTextField];
            [cellTempArray addObject:cell];
        }
        {
            TextFieldedCell *cell = [self getTextFieldedCell];
            cell.item = [_itemArray objectAtIndex:2];
            cell.valueTextField.delegate = self;
            cell.isLast = YES;
            cell.valueTextField.keyboardType = UIKeyboardTypeDecimalPad;
            cell.valueTextField.indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
            [textFieldsArray addObject:cell.valueTextField];
            [cellTempArray addObject:cell];
        }
        self.cellArray   = cellTempArray;
    }
    self.keyboardControls =[[BSKeyboardControls alloc] initWithFields:textFieldsArray];
    [self.keyboardControls setDelegate:self];
}


#pragma mark
#pragma mark UITableViewDataSource

- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.cellArray objectAtIndex:indexPath.row];
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark
#pragma mark BSKeyboardControlDelegate

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls selectedField:(UIView *)field inDirection:(BSKeyboardControlsDirection)direction
{
    GSTextField *tf = (GSTextField *)field;
    if (tf.indexPath.row < 4) {
        CGRect rect = [_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:tf.indexPath.row + 1 inSection:0]];
        [_tableView scrollRectToVisible:rect animated:YES];
        [tf performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.3];
        [tf becomeFirstResponder];
    }
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControlz
{
    [keyboardControlz.activeField resignFirstResponder];
}

#pragma mark -
#pragma mark Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    GSTextField *tf = (GSTextField *)textField;
    if (tf.indexPath.row == 4) {
        [self.keyboardControls.activeField performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:1];
    }
    else{
        [self.keyboardControls setActiveField:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    GSTextField *tf = (GSTextField *)textField;
    if (tf.indexPath.row == 0) {
        return (newLength > 30) ? NO : YES;
    }
    return (newLength > 5) ? NO : YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    GSTextField *tf = (GSTextField *)textField;
    if (tf.indexPath.row < 4) {
        GSTextField *tfz = [self.keyboardControls.fields objectAtIndex:tf.indexPath.row + 1];
        CGRect rect = [_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:tf.indexPath.row + 1 inSection:0]];
        [_tableView scrollRectToVisible:rect animated:YES];
        [tfz performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.3];
    }
    else{
        [tf resignFirstResponder];
    }
    return  YES;
}

#pragma mark KeyBoardNotification

-(void) keyboardDidShow: (NSNotification *)notif
{
    // If keyboard is visible, return
    // Get the size of the keyboard.
    NSDictionary* info = [notif userInfo];
    NSValue* aValue = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        CGRect deeshRect = _tableView.frame;
        deeshRect.size.height = CGRectGetHeight(self.view.frame) - keyboardSize.height ;
        _tableView.frame = deeshRect;
        
    }];
    // Adjust the table view by the keyboards height.
    
}

-(void) keyboardDidHide: (NSNotification *)notif
{
    // If keyboard is visible, return
    // Get the size of the keyboard.
    NSDictionary* info = [notif userInfo];
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        _tableView.frame = self.view.bounds;
    }];
    // Adjust the table view by the keyboards height.
}

-(void)viewWillAppear:(BOOL)animated    {
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardDidShow:)
                                                 name: UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector (keyboardDidHide:)
                                                 name: UIKeyboardWillHideNotification
                                               object:nil];
    
}

-(void)viewDidDisappear:(BOOL)animated  {
    [super viewDidDisappear: animated];
    //    if (isiPhone) {
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    //    }
}

-(void)setupUser{
    TextFieldedCell *cell = [cellArray objectAtIndex:0];
    NSString *name = cell.valueTextField.text;
    
    TextFieldedCell *cell1 = [cellArray objectAtIndex:2];
    NSString *height = cell1.valueTextField.text;
    
    TextFieldedCell *cell2 = [cellArray objectAtIndex:3];
    NSString *weight = cell2.valueTextField.text;
    
    CheckBoxCell *cell3 = [cellArray objectAtIndex:1];
    int  gender = cell3.selectedValue - 100;
    if (height.floatValue == 0) {
        [Utils showAlert:@"Та 0-с их утга оруулна уу."];
        return;
    }
    else if (weight.floatValue == 0) {
        [Utils showAlert:@"Та 0-с их утга оруулна уу."];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (name.length > 0 && height.length > 0 && weight.length > 0) {
        Person   *item = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:DATABASE.managedObjectContext];
        item.name = name;
        item.height = [NSNumber numberWithFloat:height.floatValue];
        item.weight = [NSNumber numberWithFloat:weight.floatValue];
        item.gender = [NSNumber numberWithFloat:gender];
        NSError *error = nil;
        if (![DATABASE.personFetchedResultController   performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [DATABASE saveChanges];
        [PersonLog createNewPersonLog:height.floatValue withWeight:weight.floatValue];
        [DatabaseManager setAdvices];
        [DatabaseManager setCup];
        [DatabaseManager setPurpose];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [USERDEF setBool:TRUE forKey:kITS_SHOW_TUT];
//        [Utils setAlarmSchedule];
        [USERDEF setObject:[NSDate date] forKey:kLAST_UPDATE_WEIGHT];
        [USERDEF setObject:[NSDate date] forKey:kFIRST_DATE];
        [USERDEF setFloat:weight.floatValue forKey:kFIRST_WEIGHT_ML];
        [APPDEL showLoginViewController];
    }
    else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [Utils showAlert:[LANGUAGE getStringForKey:@"alert_empty_field"]];
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
