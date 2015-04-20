//
//  DashboardViewController.m
//  Bonaque
//
//  Created by Puujee on 4/4/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "DashboardViewController.h"
#import "AddWaterView.h"
#import "MainCollectionViewCell.h"
#import "MainAdviceCollectionViewCell.h"
#import "MainPurposeCollectionViewCell.h"
#import "AdviceDetailViewController.h"
#import "UpdateWeightView.h"
#import "AddCupViewController.h"
#import "InAppAlarmView.h"
#import "DialogView.h"
#import "AdviceViewController.h"
#import "PurposeViewController.h"
#import "UIView+Toast.h"

@interface DashboardViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, AddWaterViewDelegate, UpdateWeightViewDelegate, MainCollectionViewCellDelegate, AddCupViewControllerDelegate>{
    
    UICollectionView *mainCollectionView;
    
    BOOL nibMyCellloaded;
    BOOL nibMyAdviceCellloaded;
    BOOL nibMyPurposeCellloaded;
    
    Advice *randomAdvice;
    NSCalendar *gregorian;
}
@property (nonatomic, strong) NSArray *cellArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DashboardViewController
@synthesize cellArray = _cellArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [[LANGUAGE getArrayForKey:@"menus"] objectAtIndex:0];
    
    
    gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    randomAdvice = [DATABASE getRandomAdvice];
    
    if ([[DATABASE.purposeLogFetchedResultController fetchedObjects] count] == 0) {
        [PurposeLog createPurposeLog];
    }
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.minimumLineSpacing = 0;
    collectionViewLayout.minimumInteritemSpacing = 10;
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionViewLayout];
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    mainCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    mainCollectionView.showsHorizontalScrollIndicator = NO;
    mainCollectionView.backgroundColor = BG_COLOR;
    [mainCollectionView registerClass:[MainCollectionViewCell class] forCellWithReuseIdentifier:@"MY_CELL"];
    [mainCollectionView registerClass:[MainAdviceCollectionViewCell class] forCellWithReuseIdentifier:@"MY_ADVICE_CELL"];
    [mainCollectionView registerClass:[MainPurposeCollectionViewCell class] forCellWithReuseIdentifier:@"MY_PURPOSE_CELL"];

    [self.view addSubview:mainCollectionView];
    
    
//    UIButton *addWaterButton = [UIButton buttonWithType:UIButtonTypeCustom];
////    [addWaterButton setBackgroundImage:[HXColor imageWithColor:UIColorFromRGB(0x394979)] forState:UIControlStateNormal];
//    addWaterButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 60, CGRectGetHeight(self.view.frame) - 60, 50, 50);
//    [addWaterButton setImage:[UIImage imageNamed:@"ic_plus"] forState:UIControlStateNormal];
//    addWaterButton.clipsToBounds = YES;
//    addWaterButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//    [addWaterButton addTarget:self action:@selector(addWater) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:addWaterButton];
}


-(void)checkWeightReminder{
    NSDate *date = [USERDEF objectForKey:kLAST_UPDATE_WEIGHT];
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
    int day = [Utils getIntervalWeightReminder];
    if (components.day >= day) {
        UpdateWeightView *pickerContainer = [[UpdateWeightView alloc] initWithFrame:self.view.window.bounds];
        pickerContainer.delegate = self;
        pickerContainer.tag  = 201;
        pickerContainer.title = @"Таны өнөөдрийн жин";
        [self.view.window addSubview:pickerContainer];
        
        [pickerContainer showContentView];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [mainCollectionView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [mainCollectionView reloadData];
    [self checkWeightReminder];
    

}

-(void)addWater{
    AddCupViewController *viewController = [[AddCupViewController alloc] initWithNibName:nil bundle:nil];
//    viewController.item = randomAdvice;
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)addCupCompleted:(Cup *)cup{
    int lastDrinked = (int)[USERDEF integerForKey:kLAST_DRINKED_ML];
    [self.view makeToast:[NSString stringWithFormat:@"Та %d мл ус уулаа.", lastDrinked] duration:4 position:[NSValue valueWithCGPoint:CGPointMake(self.view.center.x, CGRectGetHeight(self.view.frame) - 60)] undoButton:^{
        int lastDrinked = (int)[USERDEF integerForKey:kLAST_DRINKED_ML];
        if (lastDrinked > 0) {
            [USERDEF setInteger:0 forKey:kLAST_DRINKED_ML];
            PersonLog *lastLog = [DATABASE getTodaysPersonLog];
            
            float currentSize = lastLog.currentWaterLitre.floatValue - lastDrinked;
            float dailyGoal = lastLog.waterGoal.floatValue ;
            float percent = currentSize/(dailyGoal/100);
            lastLog.currentWaterLitre = [NSNumber numberWithFloat:currentSize];
            lastLog.currentWaterPercent = [NSNumber numberWithFloat:percent];
            NSError *error = nil;
            if (![DATABASE.personLogFetchedResultController   performFetch:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
            [DATABASE saveChanges];
            [mainCollectionView reloadData];
        }
    }];
}

#pragma mark    UpdateWeightViewDelegate

-(void)didFinishUpdateWeight{
    [mainCollectionView reloadData];
}


#pragma mark
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        
        if(!nibMyCellloaded)
        {
            UINib *nib = [UINib nibWithNibName:@"MainCollectionViewCell" bundle: nil];
            [cv registerNib:nib forCellWithReuseIdentifier:@"MY_CELL"];
            nibMyCellloaded = YES;
        }
        MainCollectionViewCell   *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
        cell.delegate = self;
        [cell updateDatas];
        return cell;
    }
    if (indexPath.section == 1 &&indexPath.row == 0) {
        if(!nibMyAdviceCellloaded)
        {
            UINib *nib = [UINib nibWithNibName:@"MainAdviceCollectionViewCell" bundle: nil];
            [cv registerNib:nib forCellWithReuseIdentifier:@"MY_ADVICE_CELL"];
            nibMyAdviceCellloaded = YES;
        }
        MainAdviceCollectionViewCell   *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_ADVICE_CELL" forIndexPath:indexPath];
        [cell layoutSubviews];
        cell.item = randomAdvice;
        return cell;
    }
    if(!nibMyPurposeCellloaded)
    {
        UINib *nib = [UINib nibWithNibName:@"MainPurposeCollectionViewCell" bundle: nil];
        [cv registerNib:nib forCellWithReuseIdentifier:@"MY_PURPOSE_CELL"];
        nibMyPurposeCellloaded = YES;
    }
    MainPurposeCollectionViewCell   *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_PURPOSE_CELL" forIndexPath:indexPath];
    [cell layoutSubviews];
//    cell.item = randomAdvice;
    return cell;
 
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([UIScreen isiPhone4]) {
            return CGSizeMake(CGRectGetWidth(self.view.bounds) - 20, 257);
        }
        return CGSizeMake(CGRectGetWidth(self.view.bounds) - 20, (CGRectGetHeight(self.view.bounds) /3*2 - 20));
    }
    CGFloat width = (self.view.bounds.size.width-10*3)/2;
    
    return CGSizeMake(width, (CGRectGetHeight(self.view.bounds) /3  - 10));
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    [delegate didSelectSuggest:[self.sectionItem.allObjects objectAtIndex:indexPath.row]];
    //    [self presentViewController:detailViewController animated:YES completion:nil];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            AdviceViewController *viewController = [[AdviceViewController alloc] initWithNibName:nil bundle:nil];
//            viewController.item = randomAdvice;
            viewController.isNavigation = YES;
            [self.navigationController pushViewController:viewController animated:YES];
        }
        else{
            PurposeViewController *viewController = [[PurposeViewController alloc] initWithNibName:nil bundle:nil];
            //            viewController.item = randomAdvice;
            viewController.isNavigation = YES;
            [self.navigationController pushViewController:viewController animated:YES];
        }

    }
}

#pragma mark


-(void)addCupsClicked{
    [self addWater];
}

-(void)toastUndoButtonClicked{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark AddWaterViewDelegate

-(void)addedWaterLitre:(float)water{

    
//    MainCollectionViewCell *cell = (MainCollectionViewCell *)[mainCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    [cell updateDatas];
//    [mainCollectionView reloadData];
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
