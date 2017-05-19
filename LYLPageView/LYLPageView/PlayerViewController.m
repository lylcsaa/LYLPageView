//
//  PlayerViewController.m
//  LYLPageView
//
//  Created by wlx on 2017/5/17.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "PlayerViewController.h"

#import "LYLPageView.h"
@interface PlayerViewController ()<LYLPageViewDelegate>

@end

@implementation PlayerViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor greenColor];
    NSArray *titles = @[@"热门",@"经典",@"最新",@"更多"];
    LYLPageViewStyle *style = [[LYLPageViewStyle alloc] init];
    style.kEnableScroll = NO;
    style.pageCollectionStyle = LYLPageCollectionStyleTitleBottom;
    LYLPageView *pageView = [[LYLPageView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds) - 300, self.view.bounds.size.width, 300) titles:titles style:style];
    pageView.delegate = self;
    [self.view addSubview:pageView];
}
-(LYLPageColumAndRow)lyl_pageView:(LYLPageView*)pageView columAndRowsInPerSection:(NSInteger)section
{
    return LYLPageColumAndRowsMake(4, 3);
}
-(void)lyl_pageView:(LYLPageView*)pageView didSelectWithIndexPath:(NSIndexPath*)indexPath
{
    NSLog(@"点击了第%zd组,第%zd个item", indexPath.section, indexPath.row);
}
-(UICollectionViewCell*)lyl_pageView:(LYLPageView*)pageView collectionView:(UICollectionView *)collectionView cellForRowInIndexPath:(NSIndexPath *)indexPath reuserIdentifer:(NSString *)reuserIdentifer
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserIdentifer forIndexPath:indexPath];
    cell.backgroundColor = [UIColor rondomColor];
    return cell;
}
-(NSInteger)lyl_pageView:(LYLPageView*)pageView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
@end
