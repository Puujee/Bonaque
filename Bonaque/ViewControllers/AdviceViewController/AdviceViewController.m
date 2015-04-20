//
//  AdviceViewController.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AdviceViewController.h"
#import "AdviceTableViewCell.h"
#import "AdviceDetailViewController.h"

@interface AdviceViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *itemArray;
@end

@implementation AdviceViewController
@synthesize itemArray = _itemArray;

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.separatorColor = CLEAR_COLOR;
        //        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_tableView registerNib:[UINib nibWithNibName:@"AdviceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        {
            UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160)];
            tableHeaderView.backgroundColor = UIColorFromRGB(0xa9cadb);
            
            UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 100, CGRectGetHeight(tableHeaderView.frame))];
            bgImageView.image = [UIImage imageNamed:@"imd_advice_big"];
            bgImageView.contentMode = UIViewContentModeScaleAspectFit;
            [tableHeaderView addSubview:bgImageView];
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(bgImageView.frame) + 10, 30, CGRectGetWidth(self.view.frame) - (CGRectGetMaxX(bgImageView.frame) + 20), CGRectGetHeight(tableHeaderView.frame) - 50)];
            label.textAlignment = NSTextAlignmentLeft;
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
            label.backgroundColor = CLEAR_COLOR;
            label.numberOfLines = 99;
            label.text = @"World Health Organization. Guidelines for drinking water quality 4th edition. 2011.\n\nХөдөөгийн хүн амын ус хангамж, ариун цэвэр, эрүүл ахуй ном. 2007 он.";
            label.lineBreakMode = NSLineBreakByWordWrapping;
            label.textColor = [UIColor whiteColor];
            [tableHeaderView addSubview:label];
            
            _tableView.tableHeaderView = tableHeaderView;
        }
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [[LANGUAGE getArrayForKey:@"menus"] objectAtIndex:2];
    _itemArray = [DATABASE getAdviceLanguageArray];
    
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
    
    AdviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[AdviceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] ;
    }
    cell.item = [_itemArray objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AdviceDetailView *pickerContainer = [[AdviceDetailView alloc] initWithFrame:[[APPDEL window] bounds]];
    //    pickerContainer.delegate = self;
    pickerContainer.item = [_itemArray objectAtIndex:indexPath.row];
    pickerContainer.mainViewController = self;
    pickerContainer.tag  = 201;
    [[APPDEL window] addSubview:pickerContainer];
    
    [pickerContainer showContentView];
    
//    AdviceDetailViewController *viewController = [[AdviceDetailViewController alloc] initWithNibName:nil bundle:nil];
//    viewController.item = [_itemArray objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:viewController animated:YES];

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
