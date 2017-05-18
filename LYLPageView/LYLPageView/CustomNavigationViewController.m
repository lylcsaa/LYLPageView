//
//  CustomNavigationViewController.m
//  LYLPageView
//
//  Created by wlx on 2017/5/17.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "CustomNavigationViewController.h"
#import <objc/runtime.h>
@interface CustomNavigationViewController ()

@end

@implementation CustomNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  UIGestureRecognizer *gr = self.interactivePopGestureRecognizer;
    NSArray *values = [gr valueForKeyPath:@"_targets"];
    id object = values.firstObject;
    id target = [object valueForKeyPath:@"target"];
    NSLog(@"---:%@",target);
    SEL action = @selector(handleNavigationTransition:);
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
    [self.view addGestureRecognizer:pan];
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
