//
//  AdviceDetailViewController.m
//  Bonaque
//
//  Created by Puujee on 4/14/15.
//  Copyright (c) 2015 Od Innovation LLC. All rights reserved.
//

#import "AdviceDetailViewController.h"

@interface AdviceDetailViewController (){
    UIScrollView *scrollView;
    
    UILabel *textLabel;
    UILabel *contentLabel;
    
    UIImageView *imageView;
}

@end

@implementation AdviceDetailViewController

@synthesize item = _item;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [[LANGUAGE getArrayForKey:@"menus"] objectAtIndex:2];
    [self showBackButton];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    scrollView.clipsToBounds = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    //        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:scrollView];
    
    textLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, CGRectGetWidth(self.view.frame) - 30, 10)];
    textLabel.backgroundColor = CLEAR_COLOR;
    textLabel.numberOfLines = 999;
    textLabel.textColor = [UIColor blackColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.f];
    textLabel.text = @"";
    [scrollView addSubview:textLabel];
    
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, CGRectGetWidth(self.view.frame) - 30, 60)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:imageView];
    
    contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, CGRectGetWidth(self.view.frame) - 30, 10)];
    contentLabel.backgroundColor = CLEAR_COLOR;
    contentLabel.numberOfLines = 999;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.f];
    contentLabel.text = @"";
    [scrollView addSubview:contentLabel];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadDatas];
}

-(void)loadDatas{
    
    
    imageView.frame = CGRectMake(15, 10, CGRectGetWidth(self.view.frame) - 30, 60);
    imageView.image = [UIImage imageNamed:_item.icon];
    
    CGRect titleSize = [_item.title boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame) - 30, 9999)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:textLabel.font}
                                           context:nil];
    textLabel.text = _item.title;
    textLabel.frame = CGRectMake(15, CGRectGetMaxY(imageView.frame) + 10, CGRectGetWidth(self.view.frame) - 30, titleSize.size.height);
    

    
    CGRect contentSize = [_item.content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.frame) - 30, 9999)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:contentLabel.font}
                                            context:nil];
    contentLabel.text = _item.content;
    contentLabel.frame = CGRectMake(15, CGRectGetMaxY(textLabel.frame) + 10, CGRectGetWidth(self.view.frame) - 30, contentSize.size.height);
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(contentLabel.frame));
    if (scrollView.contentSize.height <= CGRectGetHeight(self.view.frame)) {
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(self.view.frame) + 1);

    }
}

-(void)setItem:(Advice *)item{
    _item = item;
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
