//
//  LYLPageView.m
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "LYLPageView.h"
@interface LYLPageView ()
@property(nonatomic,strong) NSArray *titles;
/**
 **:自控制器
 **/
@property (nonatomic,strong)NSArray *childViewControllers;
/**
 **:样式
 **/
@property (nonatomic,strong)LYLPageViewStyle *style;

/**
 **:父识图
 **/
@property (nonatomic,weak) UIViewController *fatherViewController;

/**
 **:标题栏
 **/
@property (nonatomic,strong)LYLTitleView *titleView;
/**
 **:内容
 **/
@property (nonatomic,strong)LYLContainerView *containerView;

@end
@implementation LYLPageView

-(instancetype)initWithFrame:(CGRect)frame
                      titles:(NSArray*)titles
        childViewControllers:(NSArray*)childViewControllers
        fatherViewController:(UIViewController*)fatherViewController
                       style:(LYLPageViewStyle*)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.fatherViewController = fatherViewController;
        self.childViewControllers = childViewControllers;
        self.style = style;
        [self setUpUI];
    }
    return self;
}
-(LYLTitleView *)titleView
{
    if (!_titleView) {
        _titleView = [[LYLTitleView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.style.kTitleViewHeight) titles:self.titles style:self.style];
    }
    return _titleView;
}
-(LYLContainerView *)containerView
{
    if (!_containerView) {
        _containerView = [[LYLContainerView alloc] initWithFrame:CGRectMake(0, self.style.kTitleViewHeight, self.bounds.size.width, self.bounds.size.height - self.style.kTitleViewHeight) childVcs:self.childViewControllers fatherVc:self.fatherViewController style:self.style];
    }
    return _containerView;
}
-(void)setUpUI
{
    [self addSubview:self.titleView];
    [self addSubview:self.containerView];
    
    self.titleView.delegate = self.containerView;
    self.containerView.delegate = self.titleView;
}
@end
