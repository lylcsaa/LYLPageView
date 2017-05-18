//
//  ViewController.m
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//
#import "UIColor+RondomColor.h"
#import "ViewController.h"
#import "LYLPageView.h"
#import "HomePageViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titles = @[@"推荐",@"猜你喜欢",@"视频",@"今日要闻",@"今日财经",@"搞笑动图",@"军事",@"我的关注"];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < titles.count; i ++) {
        
        HomePageViewController *vc = [[HomePageViewController alloc] init];
        vc.view.backgroundColor = [UIColor rondomColor];
        [arrM addObject:vc];
    }
    LYLPageViewStyle *style = [[LYLPageViewStyle alloc] init];
    style.maskStyle = LYLTitleViewMaskStyleRoundMask;
    style.titleViewAnimationStyle = LYLTitleViewAnimationStyleNormal;
    LYLPageView *pageView = [[LYLPageView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64) titles:titles childViewControllers:arrM fatherViewController:self style:style];
    [self.view addSubview:pageView];
}
//-(void)setUpUI
//{
//    LYLPageViewController *pvc = [[LYLPageViewController alloc] init];
//    NSArray *titles = @[@"推荐",@"猜你喜欢",@"视频",@"今日要闻",@"今日财经",@"搞笑动图",@"军事",@"我的关注"];
//    for (int i = 0; i < titles.count; i ++) {
//        NSString *title = titles[i];
//        UIViewController *vc = [[UIViewController alloc] init];
//        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
//        [pvc lyl_addChildViewController:vc title:title];
//    }
//    [pvc lyl_loadView];
//    [self.navigationController pushViewController:pvc animated:YES];
//}

@end
