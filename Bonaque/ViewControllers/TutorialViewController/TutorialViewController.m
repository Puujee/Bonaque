//
//  TutorialViewController.m
//  Bonaque
//
//  Created by Puujee on 4/4/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "TutorialViewController.h"
#import "TutorialCollectionViewCell.h"
#import "AddUserViewController.h"
#import "TutorialItem.h"

@interface TutorialViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>{
    UICollectionView *headerCollectionView;
    UIPageControl *bottomPageControll;
    UIButton *skipButton;
}
@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation TutorialViewController
@synthesize imageArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildItem];
    
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.minimumLineSpacing = 0;
    collectionViewLayout.minimumInteritemSpacing = 0;
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    collectionViewLayout.headerReferenceSize = CGSizeZero;
    
    
    headerCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:collectionViewLayout];
    headerCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    headerCollectionView.pagingEnabled = YES;
    headerCollectionView.delegate = self;
    headerCollectionView.dataSource = self;
    headerCollectionView.bounces = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    headerCollectionView.showsHorizontalScrollIndicator = NO;
    headerCollectionView.backgroundColor = [UIColor greenColor];
    [headerCollectionView registerClass:[TutorialCollectionViewCell class] forCellWithReuseIdentifier:@"MY_CELL"];
    //    headerCollectionView.backgroundColor = CLEAR_COLOR;
    [self.view addSubview:headerCollectionView];
    
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 50, CGRectGetWidth(self.view.frame), 50)];
    bottomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
    [self.view addSubview:bottomView];
    {
        
        bottomPageControll = [[UIPageControl alloc] initWithFrame:CGRectMake(100, 10, CGRectGetWidth(self.view.frame) - 200, 30)];
        bottomPageControll.backgroundColor = CLEAR_COLOR;
        bottomPageControll.numberOfPages = 5;
        [bottomView addSubview:bottomPageControll];
        
        skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [skipButton setTitle:[[LANGUAGE getStringForKey:@"start"] uppercaseString] forState:UIControlStateNormal];
        [skipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [skipButton setImage:[UIImage imageNamed:@"ic_next"] forState:UIControlStateNormal];
        [skipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [skipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        skipButton.titleLabel.font = [UIFont systemFontOfSize:16];
        skipButton.frame = CGRectMake(CGRectGetWidth(self.view.frame) - 60, 5, 50, 40);
        skipButton.hidden  = NO;
        [skipButton addTarget:self action:@selector(skipTutorial) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:skipButton];
    }
}

-(void)buildItem{
    NSMutableArray *tempArray = [NSMutableArray array];
    {
        TutorialItem *item = [TutorialItem new];
        item.color = UIColorFromRGB(0xa9cadb);
//        item.title = @"Таны усны хэрэгцээнд хяналт тавина";
        item.imageName = @"img_tutorial_1";
        [tempArray addObject:item];
    }
    {
        TutorialItem *item = [TutorialItem new];
        item.color = UIColorFromRGB(0x72a5c2);
//        item.title = @"Таны жингийн 70% нь ус байдаг";
        item.imageName = @"img_tutorial_2";
        [tempArray addObject:item];
    }
    {
        TutorialItem *item = [TutorialItem new];
        item.color = UIColorFromRGB(0x3aaad2);
//        item.title = @"Өдөрт хэр их ус уух ёстойгоо мэдэж аваарай";
        item.imageName = @"img_tutorial_3";
        [tempArray addObject:item];
    }
    {
        TutorialItem *item = [TutorialItem new];
        item.color = UIColorFromRGB(0x0b86b0);
//        item.title = @"Хэзээ ус уухыг чинь сануулна";
        item.imageName = @"img_tutorial_4";
        [tempArray addObject:item];
    }
    {
        TutorialItem *item = [TutorialItem new];
        item.color = UIColorFromRGB(0x0b86b0);
        //        item.title = @"Хэзээ ус уухыг чинь сануулна";
        item.imageName = @"img_tutorial_5";
        [tempArray addObject:item];
    }
    imageArray = tempArray;
}

-(void)skipTutorial{
    AddUserViewController *viewController = [[AddUserViewController  alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:viewController    animated:YES];
}

#pragma mark
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
//    return 4;
    return imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    TutorialCollectionViewCell   *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    [cell layoutSubviews];
    cell.item = [imageArray objectAtIndex:indexPath.row];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    CGFloat height = (self.view.bounds.size.width /3  )*2;
    
    return CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    [delegate didSelectSuggest:[self.sectionItem.allObjects objectAtIndex:indexPath.row]];
    //    ChartDetailVieViewController *detailViewController = [[ChartDetailVieViewController   alloc] initWithNibName:nil bundle:nil];
    //    detailViewController.item    = [_chartData objectAtIndex:indexPath.row];
    //    [self presentViewController:detailViewController animated:YES completion:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == headerCollectionView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        bottomPageControll.currentPage = page;
        if (scrollView.contentOffset.x/scrollView.frame.size.width == 3) {
            skipButton.hidden = NO;
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
