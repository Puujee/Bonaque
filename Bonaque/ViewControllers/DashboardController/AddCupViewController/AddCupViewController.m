//
//  AddCupViewController.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AddCupViewController.h"
#import "CupCollectionViewCell.h"
#import "EmptyCollectionViewCell.h"
#import "AddCustomCupView.h"
#import "InAppAlarmView.h"
#import "DialogView.h"

@interface AddCupViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, AddCustomCupViewDelegate >{
    UICollectionView *cupCollectionView;
}

@property (nonatomic, strong) NSArray *itemArray;

@end

@implementation AddCupViewController
@synthesize itemArray = _itemArray;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenName = @"AddCupViewController";

    [self showBackButton];
    self.title = [LANGUAGE getStringForKey:@"water_size"];
    
    _itemArray = [DATABASE.cupFetchedResultController fetchedObjects];
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.minimumLineSpacing = 10;
    collectionViewLayout.minimumInteritemSpacing = 10;
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    cupCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:collectionViewLayout];
    cupCollectionView.delegate = self;
    cupCollectionView.dataSource = self;
    cupCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    cupCollectionView.showsHorizontalScrollIndicator = NO;
    [cupCollectionView registerClass:[CupCollectionViewCell class] forCellWithReuseIdentifier:@"MY_CELL"];
    [cupCollectionView registerClass:[EmptyCollectionViewCell class] forCellWithReuseIdentifier:@"MY_EMPTY_CELL"];

    cupCollectionView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    [self.view addSubview:cupCollectionView];
}

#pragma mark
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return _itemArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row < _itemArray.count) {
        CupCollectionViewCell   *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
        [cell layoutSubviews];
        cell.item = [_itemArray objectAtIndex:indexPath.row];
        return cell;
    }
    EmptyCollectionViewCell   *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_EMPTY_CELL" forIndexPath:indexPath];
    [cell layoutSubviews];
//    cell.item = [_itemArray objectAtIndex:indexPath.row];
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (self.view.bounds.size.width-10*3)/2;
    return CGSizeMake(width, width - 30);
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    [delegate didSelectSuggest:[self.sectionItem.allObjects objectAtIndex:indexPath.row]];
    //    [self presentViewController:detailViewController animated:YES completion:nil];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.row  < _itemArray.count) {
        Cup *cup = [_itemArray objectAtIndex:indexPath.row];
        PersonLog *lastLog = [DATABASE getTodaysPersonLog];
        
        float currentSize = lastLog.currentWaterLitre.floatValue + cup.ml.floatValue;
        float dailyGoal = lastLog.waterGoal.floatValue ;
        float percent = currentSize/(dailyGoal/100);
        lastLog.currentWaterLitre = [NSNumber numberWithFloat:currentSize];
        lastLog.currentWaterPercent = [NSNumber numberWithFloat:percent];
        [USERDEF setInteger:cup.ml.floatValue forKey:kLAST_DRINKED_ML];
        NSError *error = nil;
        if (![DATABASE.personLogFetchedResultController   performFetch:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        [DATABASE saveChanges];
        [DATABASE updatePurposeLog];
        if (lastLog.currentWaterPercent.floatValue >= 100) {
            [Utils changeAlarmsDate];
            DialogType type = kCongrulateDialog;
            if (lastLog.currentWaterPercent.floatValue > 120 && lastLog.currentWaterPercent.floatValue <= 160) {
                type = kWarningDialog;
            }
            else if (lastLog.currentWaterPercent.floatValue  > 160){
                type = kSuperWarningDialog;
            }
            DialogView *pickerContainer = [[DialogView alloc] initWithFrame:self.view.window.bounds];
            //    pickerContainer.delegate = self;
            pickerContainer.type  = type;
            [self.view.window addSubview:pickerContainer];
            [pickerContainer showContentView];
        }
        [delegate addCupCompleted:cup];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        AddCustomCupView *pickerContainer = [[AddCustomCupView alloc] initWithFrame:self.view.window.bounds];
        pickerContainer.title = [LANGUAGE getStringForKey:@"new_cup_add"];
        pickerContainer.delegate = self;
        pickerContainer.tag  = 201;
        [self.view.window addSubview:pickerContainer];
        
        [pickerContainer showContentView];
    }
}

#pragma mark AddCustomCupViewDelegate

-(void)didFinishAddCup{
    [self checkShowDialog];
    [delegate addCupCompleted:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)checkShowDialog{
    PersonLog *lastLog = [DATABASE getTodaysPersonLog];
    if (lastLog.currentWaterPercent.floatValue >= 100) {
        
        DialogType type = kCongrulateDialog;
        if (lastLog.currentWaterPercent.floatValue > 120 && lastLog.currentWaterPercent.floatValue <= 160) {
            type = kWarningDialog;
        }
        else if (lastLog.currentWaterPercent.floatValue  > 160){
            type = kSuperWarningDialog;
        }
        DialogView *pickerContainer = [[DialogView alloc] initWithFrame:self.view.window.bounds];
        //    pickerContainer.delegate = self;
        pickerContainer.type  = type;
        [self.view.window addSubview:pickerContainer];
        [pickerContainer showContentView];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _itemArray = [DATABASE.cupFetchedResultController fetchedObjects];
    [cupCollectionView   reloadData];
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
