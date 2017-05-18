//
//  LYLPageView.m
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "LYLPageView.h"
@interface LYLPageView ()<UICollectionViewDelegate, UICollectionViewDataSource>
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


/**
 **:collectionView
 **/
@property (nonatomic,strong)UICollectionView *pageCollectionView;
/**
 **:pageControl
 **/
@property (nonatomic,strong)UIPageControl *pageControl;

@end
@implementation LYLPageView
NSString *reuseCellId = @"cell";
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






-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles style:(LYLPageViewStyle *)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.style = style;
        [self setUpPageUI];
    }
    return self;
}

-(UICollectionView *)pageCollectionView
{
    if (!_pageCollectionView) {
        LYLPageCollectionLayout *layout = [[LYLPageCollectionLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _pageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.bounds), self.bounds.size.width, self.bounds.size.height - self.style.kPageControlHeight - self.style.kTitleViewHeight) collectionViewLayout:layout];
        _pageCollectionView.delegate = self;
        _pageCollectionView.dataSource = self;
        _pageCollectionView.backgroundColor = [UIColor rondomColor];
        _pageCollectionView.pagingEnabled = YES;
        [_pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseCellId];
    }
    return _pageCollectionView;
}
-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageCollectionView.frame), self.bounds.size.width, self.style.kPageControlHeight)];
        _pageControl.numberOfPages = 4;
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor rondomColor];
    }
    return _pageControl;
}
-(void)setUpPageUI
{
    [self addSubview:self.titleView];
    [self addSubview:self.pageCollectionView];
    [self addSubview:self.pageControl];
}
#pragma mark --- collectionViewDataSource--
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor rondomColor];
    return cell;
}




#pragma mark -- collectionViewDelegate--
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


}
@end
