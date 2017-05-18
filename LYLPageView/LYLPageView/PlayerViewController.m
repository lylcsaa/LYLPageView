//
//  PlayerViewController.m
//  LYLPageView
//
//  Created by wlx on 2017/5/17.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "PlayerViewController.h"

#import "LYLPageView.h"
@interface PlayerViewController ()

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
    LYLPageView *pageView = [[LYLPageView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 300) titles:titles style:style];
    [self.view addSubview:pageView];
}

@end
