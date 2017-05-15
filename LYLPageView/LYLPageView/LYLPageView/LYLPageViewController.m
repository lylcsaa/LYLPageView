//
//  LYLPageViewController.m
//  LYLPageView
//
//  Created by wlx on 17/5/15.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "LYLPageViewController.h"
#import "LYLPageView.h"
@interface LYLPageViewController ()
/**
 **:自控制器
 **/
@property (nonatomic,strong)NSMutableArray * childViewControllers;
/**
 **:标题
 **/
@property (nonatomic,strong)NSMutableArray * titles;
@end

@implementation LYLPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)lyl_addChildViewController:(UIViewController*)controller title:(NSString *)title
{
    [self.childViewControllers addObject:controller];
    [self.titles addObject:title];
}
-(NSMutableArray *)titles
{
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}
-(NSMutableArray*)childViewControllers
{
    if (!_childViewControllers) {
        _childViewControllers = [NSMutableArray array];
    }
    return _childViewControllers;
}
-(void)lyl_loadView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
//    NSArray *titles = @[@"推荐",@"猜你喜欢",@"视频",@"今日要闻",@"今日财经",@"搞笑动图",@"军事",@"我的关注"];
    
    NSMutableArray *arrM = [NSMutableArray array];
    for (int i = 0; i < self.titles.count; i ++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        [arrM addObject:vc];
    }
    LYLPageViewStyle *style = [[LYLPageViewStyle alloc] init];
    style.maskStyle = LYLTitleViewMaskStyleRoundMask;
    LYLPageView *pageView = [[LYLPageView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-64) titles:self.titles childViewControllers:arrM fatherViewController:self style:style];
    [self.view addSubview:pageView];
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
