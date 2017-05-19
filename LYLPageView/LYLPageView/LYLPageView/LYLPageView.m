//
//  LYLPageView.m
//  LYLPageView
//
//  Created by wlx on 17/5/12.
//  Copyright © 2017年 Tim. All rights reserved.
//

#import "LYLPageView.h"
@interface LYLPageView ()<UICollectionViewDelegate, UICollectionViewDataSource,LYLTitleViewDelegate>
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

/**
 **:<#注释#>
 **/
@property (nonatomic,assign)NSInteger currentSection;


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
        self.numberOfColums = 4;
        self.numberOfRows = 2;
        self.backgroundColor = self.style.pageViewBackgroundColor;
        [self setUpPageUI];
    }
    return self;
}

-(UICollectionView *)pageCollectionView
{
    if (!_pageCollectionView) {
        LYLPageCollectionLayout *layout = [[LYLPageCollectionLayout alloc] init];
        layout.minimumLineSpacing = self.style.minimumLineSpacing;
        layout.minimumInteritemSpacing = self.style.minimumInteritemSpacing;
        layout.dataSource = self;
        _pageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _pageCollectionView.delegate = self;
        _pageCollectionView.dataSource = self;
        _pageCollectionView.backgroundColor = self.style.collectionViewBackgroundColor;
        _pageCollectionView.pagingEnabled = YES;
        _pageCollectionView.contentInset = self.style.edgeInsets;
        _pageCollectionView.showsVerticalScrollIndicator = NO;
        _pageCollectionView.showsHorizontalScrollIndicator = NO;
        [_pageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseCellId];
    }
    return _pageCollectionView;
}
-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.pageCollectionView.frame), self.bounds.size.width, self.style.kPageControlHeight)];
        _pageControl.currentPageIndicatorTintColor = self.style.pageControlSelectedColor;
        _pageControl.pageIndicatorTintColor = self.style.pageControlUnSelectedColor;
        _pageControl.numberOfPages = 4;
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = self.style.pageCantrolBackgroundColor;
    }
    return _pageControl;
}
-(void)setUpPageUI
{
    [self addSubview:self.titleView];
    [self addSubview:self.pageCollectionView];
    
    if (self.style.pageCollectionStyle == LYLPageCollectionStyleTitleBottom) {
        self.pageCollectionView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.style.kTitleHeight - self.style.kPageControlHeight);
        self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.pageCollectionView.frame), self.bounds.size.width, self.style.kPageControlHeight);
        self.titleView.frame = CGRectMake(0, CGRectGetMaxY(self.pageControl.frame), self.bounds.size.width, self.style.kTitleHeight);
        [self addSubview:self.pageControl];
    }else if (self.style.pageCollectionStyle == LYLPageCollectionStyleTitleTop){
        self.pageCollectionView.frame = CGRectMake(0, CGRectGetMaxY(self.titleView.bounds), self.bounds.size.width, self.bounds.size.height - self.style.kPageControlHeight - self.style.kTitleViewHeight);
        self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.pageCollectionView.frame), self.bounds.size.width, self.style.kPageControlHeight);
        [self addSubview:self.pageControl];
    }else if (self.style.pageCollectionStyle == LYLPageCollectionStyleNormal){
        self.pageCollectionView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.style.kPageControlHeight);
        self.pageControl.frame = CGRectMake(0, CGRectGetMaxY(self.pageCollectionView.frame), self.bounds.size.width, self.style.kPageControlHeight);
        [self addSubview:self.pageControl];
    }
    self.titleView.delegate = self;
}
#pragma mark --- collectionViewDataSource--
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.titles.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.delegate lyl_pageView:self numberOfRowsInSection:section];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSInteger numberOfItems = [self.pageCollectionView numberOfItemsInSection:indexPath.section];
        LYLPageColumAndRow R = [self pageColumAndRowInSection:indexPath.section];
        NSInteger numberOfpages = numberOfItems/(R.rows*R.colums) + 1;
        self.pageControl.numberOfPages = numberOfpages;
    }
    UICollectionViewCell *cell = [self.delegate lyl_pageView:self collectionView:collectionView cellForRowInIndexPath:indexPath reuserIdentifer:reuseCellId];
    return cell;
}

#pragma mark -- titleViewdelegate--
-(void)titleView:(LYLTitleView *)titleView didSelectedItemIndex:(int)selectedIndex
{
    [self.pageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:selectedIndex] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}
#pragma mark -- pageCollectionLayoutDatasource ---
-(void)pageLayout:(LYLPageCollectionLayout *)layout pageInSection:(NSInteger)section page:(NSInteger)page currentPage:(NSInteger)currentPage
{
    self.pageControl.numberOfPages = page;
    self.pageControl.currentPage = currentPage;
    if (section == self.currentSection) {
        return;
    }else{
        [self.titleView selectIndex:section];
        self.currentSection = section;
    }
}
-(LYLPageColumAndRow)pageColumAndRowInSection:(NSInteger)section
{
    LYLPageColumAndRow R = LYLPageColumAndRowsMake(self.numberOfColums, self.numberOfRows);
    if (self.delegate && [self.delegate respondsToSelector:@selector(lyl_pageView:columAndRowsInPerSection:)]) {
        R = [self.delegate lyl_pageView:self columAndRowsInPerSection:section];
    }
    return R;
}
#pragma mark -- collectionViewDelegate--
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lyl_pageView:didSelectWithIndexPath:)]) {
        [self.delegate lyl_pageView:self didSelectWithIndexPath:indexPath];
    }

}
@end
